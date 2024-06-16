import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uni_table/accountsWorkScreen/workScreen.dart';
import 'package:uni_table/blocs/oopt/oopt_bloc.dart';
import 'package:uni_table/data/data_repository.dart';
import 'package:uni_table/data/models/latlng_adapter.dart';
import 'package:uni_table/data/models/models.dart';
import 'package:uni_table/mapWorkScreen/workScreen.dart';
import 'package:uni_table/navigationButtons.dart';
import 'package:uni_table/problemWorkScreen/workScreen.dart';
import 'package:uni_table/requestWorkScreen/workScreen.dart';

void main() async {
  final dataRepository = await initHive();
  final ooptBloc = OoptBloc(repository: dataRepository)..add(OoptsUpdate());

  runApp(MyApp(
    ooptBloc: ooptBloc,
  ));
}

Future<DataRepository> initHive() async {
  await Hive.initFlutter();

  const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  var containsEncryptionKey = await secureStorage.containsKey(key: 'key');
  if (!containsEncryptionKey) {
    var key = Hive.generateSecureKey();
    await secureStorage.write(key: 'key', value: base64UrlEncode(key));
  }
  final encryptionKey = (await secureStorage.read(key: 'key'))!;
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(OoptAdapter());
  Hive.registerAdapter(ApplicationAdapter());
  Hive.registerAdapter(LatLngAdapter());
  Hive.registerAdapter(TrailAdapter());
  Hive.registerAdapter(GeopointAdapter());
  Hive.registerAdapter(ReportAdapter());
  final userBox = await Hive.openBox<User>('user',
      encryptionCipher: HiveAesCipher(base64Decode(encryptionKey)));
  final applicationBox = await Hive.openBox<Application>('application',
      encryptionCipher: HiveAesCipher(base64Decode(encryptionKey)));
  final ooptBox = await Hive.openBox<Oopt>('oopt',
      encryptionCipher: HiveAesCipher(base64Decode(encryptionKey)));
  return DataRepository(
      applicationBox: applicationBox, userBox: userBox, ooptBox: ooptBox);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.ooptBloc});

  final OoptBloc ooptBloc;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: false),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => ooptBloc,
        child: MyHomePage(
          title: '',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final PageStorageBucket _bucket = PageStorageBucket();
  late PageController _pageViewController;
  late TabController _tabController;

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
    _pageViewController = PageController();
    _tabController.addListener(() {
      _updateCurrentPageIndex(_tabController.index);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
    });
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(254, 254, 254, 1),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 0,
                left: 0,
                child: SvgPicture.asset(
                  'lib/asset/mainBackground_1.svg',
                )),
            Positioned(
                top: 0,
                right: 0,
                child: SvgPicture.asset(
                  'lib/asset/mainBackground_2.svg',
                )),
            Positioned(
              top: 15,
              right: 70,
              child: Container(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Administrator',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: const Color(0xFF2A4437),
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      height: 1,
                      letterSpacing: 0.20,
                    ),
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.logout),
                    padding: EdgeInsets.all(0),
                    iconSize: 24,
                  )
                ],
              )),
            ),
            Positioned(
                bottom: 0,
                child: SvgPicture.asset(
                  'lib/asset/mainBackground_3.svg',
                  width: MediaQuery.of(context).size.width,
                )),
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  NavigationButtons(tabController: _tabController),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.76,
                      width: MediaQuery.of(context).size.width,
                      child: IndexedStack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          PageView(
                            padEnds: true,
                            pageSnapping: true,
                            controller: _pageViewController,
                            children: <Widget>[
                              WorkScreenAccount(),
                              WorkScreenMap(),
                              WorkScreenProblem(),
                              WorkScreenRequest(),
                            ],
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
