import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:kamchatka/gen/assets.gen.dart';
import 'package:kamchatka/gen/colors.gen.dart';
import 'package:kamchatka/src/auth/login/cubit/login_cubit.dart';
import 'package:kamchatka/src/auth/register/cubit/register_cubit.dart';
import 'package:kamchatka/src/data/data_repository.dart';
import 'package:kamchatka/src/models/application.dart';
import 'package:kamchatka/src/models/geopoint.dart';
import 'package:kamchatka/src/models/latlng_adapter.dart';
import 'package:kamchatka/src/models/oopt.dart';
import 'package:kamchatka/src/models/trail.dart';
import 'package:kamchatka/src/models/user.dart';
import 'package:kamchatka/src/views/bloc/home_navigation_bloc.dart';
import 'package:kamchatka/src/views/home/children/check_in/bloc/check_in_bloc.dart';
import 'package:kamchatka/src/views/oopt/bloc/oopt_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: ColorName.generalBackground,
  ));

  //Keep splash while initializing
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //Set up locale
  await initializeDateFormatting('ru_RU');
  Intl.defaultLocale = 'ru_RU';

  //Set up settings controller
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  settingsController.updateThemeMode(ThemeMode.light);

  //Initialize secured Hive
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

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
  final userBox = await Hive.openBox<User>('user',
      encryptionCipher: HiveAesCipher(base64Decode(encryptionKey)));
  final applicationBox = await Hive.openBox<Application>('application',
      encryptionCipher: HiveAesCipher(base64Decode(encryptionKey)));
  final ooptBox = await Hive.openBox<Oopt>('oopt',
      encryptionCipher: HiveAesCipher(base64Decode(encryptionKey)));

  //Initialize blocs and providers
  DataRepository dataClient = DataRepository(
      userBox: userBox, applicationBox: applicationBox, ooptBox: ooptBox);
  await dataClient.getOopts();
  LoginCubit loginCubit = LoginCubit(dataClient);
  RegisterCubit registerCubit = RegisterCubit(dataClient);
  HomeNavigationBloc homeNavigationBloc =
      HomeNavigationBloc(dataClient: dataClient)..add(const PageTapped(0));
  OoptBloc ooptBloc = OoptBloc();
  CheckInBloc checkInBloc = CheckInBloc(dataClient: dataClient);

  //Load SVG assets
  List<SvgAssetLoader> loaders = [];
  loaders.add(SvgAssetLoader(Assets.icons.backgroundMountains.path));
  loaders.add(SvgAssetLoader(Assets.icons.backgroundLeft.path));
  loaders.add(SvgAssetLoader(Assets.icons.backgroundRight.path));
  loaders.add(SvgAssetLoader(Assets.icons.applicationsBackground.path));
  loaders.add(SvgAssetLoader(Assets.auth.background.path));
  loaders.add(SvgAssetLoader(Assets.auth.gerb.path));
  loaders.add(SvgAssetLoader(Assets.auth.ski.path));
  for (int i = 0; i < loaders.length; ++i) {
    svg.cache.putIfAbsent(
        loaders[i].cacheKey(null), () => loaders[i].loadBytes(null));
  }

  final isLoggedIn = dataClient.getUser() != null;

  FlutterNativeSplash.remove();
  runApp(
    MyApp(
      settingsController: settingsController,
      loginCubit: loginCubit,
      registerCubit: registerCubit,
      ooptBloc: ooptBloc,
      homeNavigationBloc: homeNavigationBloc,
      checkInBloc: checkInBloc,
      dataClient: dataClient,
      isLoggedIn: isLoggedIn,
    ),
  );
}
