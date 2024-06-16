import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';
import 'package:path/path.dart';
import 'package:uni_table/data/models/models.dart';

class DataRepository {
  DataRepository(
      {required this.applicationBox,
      required this.userBox,
      required this.ooptBox})
      : dio = Dio();
  final Dio dio;
  final Box<Application> applicationBox;
  final Box<User> userBox;
  final Box<Oopt> ooptBox;
  static const String _baseURL = 'https://copy-paste-adapt.ru/api';

  Future<User> loginWithCredentials({
    required String email,
    required String password,
  }) async {
    try {
      final data = {
        'email': email,
        'password': password,
      };
      final response = await dio.post(
        '$_baseURL/login',
        data: data,
      );
      final user = User.fromJson(response.data);
      await _saveUser(user: user);
      return user;
    } on Exception {
      rethrow;
    }
  }

  void logOut() async {
    _deleteUser();
  }

  Future<void> _saveUser({required User user}) async {
    await userBox.put('user', user);
  }

  User? getUser() {
    return userBox.get('user');
  }

  bool isUserLogged() => getUser() != null;

  void _deleteUser() {
    userBox.clear();
  }

  Future<void> saveCache(
      {required List<Oopt> oopts,
      required List<Application> applications}) async {
    ooptBox.clear();
    ooptBox.addAll(oopts);
    applicationBox.clear();
    applicationBox.addAll(applications);
  }

  Future<List<Oopt>> getOopts() async {
    List<Oopt> oopts;
    try {
      oopts = await _getOoptsFromServer();
    } catch (e) {
      oopts = getCachedOopts();
    }
    return oopts;
  }

  /*Future<List<Application>> getApplications() async {
    List<Application> applications = [];
    final rawData = (await dio.get('$_baseURL/getAllProposals')).data;
    final Map<String, dynamic> proposals = rawData['All Proposals'];
    for (var proposal in proposals.entries) {
      applications.add(
        Application(
            status: '',
            oopt: null,
            user: null,
            date: null,
            eventPurpose: '',
            eventFormat: '',
            media: '',
            email: '',
            number: ''),
      );
    }
    return applications;
  }

  Future<List<Report>> getReports() async {
    List<Report> reports = [];
    final rawData = (await dio.get('$_baseURL/getAllProposals')).data;
    final Map<String, dynamic> proposals = rawData['All Proposals'];
    for (var proposal in proposals.entries) {
      reports.add(
        Report(
          id: null,
          comment: '',
          geo_location: null,
          status: '',
          photos: [],
          problem_type: '',
          email: '',
          phone: '',
          user: null,
        ),
      );
    }
    return reports;
  }*/

  List<Oopt> getCachedOopts() {
    final list = ooptBox.values.toList();
    return ooptBox.values.toList();
  }

  Future<List<Application>> getUserApplications() async {
    final response = await dio.get('$_baseURL/getcurrentuserproposal',
        data: {'user_id': '${getUser()!.id}'});
    final List<dynamic> data =
        (response.data as Map<String, dynamic>)['message'];
    List<Application> applications = [];
    for (int i = 0; i < data.length; ++i) {
      final dateList = (data[i]['proposal_arrive_date'] as String).split('.');
      if (getCachedOopts()
              .firstWhere((element) => element.name == data[i]['proposal_oopt'],
                  orElse: () =>
                      Oopt(name: 'bad', border: const [], trails: const []))
              .name !=
          'bad') {
        applications.add(
          Application(
            date: DateTime(int.parse(dateList[2]), int.parse(dateList[1]),
                int.parse(dateList[0])),
            status: data[i]['proposal_status'],
            oopt: getCachedOopts().firstWhere(
                (element) => element.name == data[i]['proposal_oopt'],
                orElse: () => Oopt(
                    name: 'Вилючинский', border: const [], trails: const [])),
            user: getUser()!,
            eventPurpose: data[i]['proposal_evemt_aim'],
            eventFormat: data[i]['proposal_event_format'],
            media: data[i]['proposal_media'],
            email: data[i]['proposal_email'],
            number: '',
          ),
        );
      }
    }
    return applications;
  }

  Future<List<Oopt>> _getOoptsFromServer() async {
    List<Oopt> oopts = [];
    final data =
        (await dio.get('$_baseURL/getoopt')).data as Map<String, dynamic>;
    data.forEach((key, value) {
      String name = key;
      String? authorizedRoutes = value['Авторизованные маршруты'];
      String? activities =
          value['Активности'] == 'nan' ? null : value['Активности'];
      String? security =
          value['Безопасность'] == 'nan' ? null : value['Безопасность'];
      String? animals =
          value['Дикие животные'] == 'nan' ? null : value['Дикие животные'];
      String? docsRules = value['Документы и правила'] == 'nan'
          ? null
          : value['Документы и правила'];
      String? pets = value['Домашние животные'] == 'nan'
          ? null
          : value['Домашние животные'];
      String? infrastructure =
          value['Инфраструктура'] == 'nan' ? null : value['Инфраструктура'];
      String? howToGetTo =
          value['Как добраться'] == 'nan' ? null : value['Как добраться'];
      String? howWorks = value['Как работает природный парк'] == 'nan'
          ? null
          : value['Как работает природный парк'];
      String? firstAid = value['Медицинская помощь'] == 'nan'
          ? null
          : value['Медицинская помощь'];
      String? science = value['Научные экспедиции'] == 'nan'
          ? null
          : value['Научные экспедиции'];
      String? unauthorizedRoutes = value['Неавторизованные маршруты'] == 'nan'
          ? null
          : value['Неавторизованные маршруты'];
      String? about = value['О парке'] == 'nan' ? null : value['О парке'];
      String? office = value['Офис природного парка'] == 'nan'
          ? null
          : value['Офис природного парка'];
      String? securityFees =
          value['Охрана и штрафы'] == 'nan' ? null : value['Охрана и штрафы'];
      String? snowcrawlerRules = value['Правила для снегоходов'] == 'nan'
          ? null
          : value['Правила для снегоходов'];
      String? skiRules =
          value['Правила хели-ски'] == 'nan' ? null : value['Правила хели-ски'];
      String? nature = value['Природа'] == 'nan' ? null : value['Природа'];
      String? connectivity = value['Связь'] == 'nan' ? null : value['Связь'];
      String? gear = value['Снаряжение'] == 'nan' ? null : value['Снаряжение'];
      String? unesco =
          value['Статус ЮНЕСКО'] == 'nan' ? null : value['Статус ЮНЕСКО'];
      String? emergency = value['Экстренные ситуации'] == 'nan'
          ? null
          : value['Экстренные ситуации'];
      final points = value['points'] as Map<String, dynamic>;
      final pointsEntries = points.entries.toList()
        ..sort((e1, e2) => int.parse(e1.key).compareTo(int.parse(e2.key)));
      final List<LatLng> border = pointsEntries.map((e) {
        String latitude = e.value['longitude'];
        String longitude = e.value['latitude'];
        //try {
        return LatLng.fromSexagesimal('N $latitude" E $longitude"');
        //} catch (exc) {
        //  print(name);
        //  print(e.key);
        //  print(exc.toString());
        //}
      }).toList();

      final events = value['events'] as Map<String, dynamic>;
      final eventsEntries = events.entries.toList();
      final List<Trail> trails = [];
      for (var element in eventsEntries) {
        final trailName = element.key;
        int time = int.tryParse(element.value['Время прохождения в ч']) ?? 2;
        double distance =
            double.tryParse(element.value['Протяженность в км']) ?? 6.1;
        String wayOfTravel = element.value['Способ передвижения'];
        String months = element.value['Месяц'] ?? 'Работает постоянно';
        final temp = element.value['Точки по порядку'] as List<dynamic>;
        List<Geopoint> points = [];
        for (int i = 0; i < temp.length; ++i) {
          String pointName = temp[i].entries.first.key;
          String latitude = temp[i].entries.first.value[0];
          String longitude = temp[i].entries.first.value[1];
          LatLng coords;
          try {
            coords = LatLng.fromSexagesimal('N $latitude" E $longitude"');
          } catch (e) {
            print(name);
            print(trailName);
            print(pointName);
            print(i);
            print(e.toString());
            coords = const LatLng(1, 1);
          }
          points.add(Geopoint(pointName, coords));
        }
        trails.add(Trail(
            name: trailName,
            time: time,
            distance: distance,
            wayOfTravel: wayOfTravel,
            months: months,
            points: points));
      }
      oopts.add(Oopt(
        name: name,
        border: border,
        trails: trails,
        authorizedRoutes: authorizedRoutes,
        activities: activities,
        security: security,
        animals: animals,
        docsRules: docsRules,
        pets: pets,
        infrastructure: infrastructure,
        howToGetTo: howToGetTo,
        howWorks: howWorks,
        firstAid: firstAid,
        science: science,
        unauthorizedRoutes: unauthorizedRoutes,
        about: about,
        office: office,
        securityFees: securityFees,
        snowcrawlerRules: snowcrawlerRules,
        skiRules: skiRules,
        nature: nature,
        connectivity: connectivity,
        gear: gear,
        unesco: unesco,
        emergency: emergency,
      ));
    });
    await ooptBox.clear();
    final res = await ooptBox.addAll(oopts);
    return oopts;
  }

  List<Application> getCachedApplications() {
    return applicationBox.values.toList();
  }

  Future<void> sendApplication({
    required String email,
    required DateTime arrive,
    required String format,
    required String aim,
    required String media,
    required String ooptName,
  }) async {
    try {
      await dio.post(
        '$_baseURL/sendform',
        data: {
          'email': email,
          'arrive_date': '${arrive.day}.${arrive.month}.${arrive.year}',
          'event_format': format,
          'event_aim': aim,
          'media': media,
          'status': '0',
          'oopt': ooptName,
          'user_id': '${getUser()!.id}',
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> sendReport({
    required String comment,
    required String type,
    required List<String?> paths,
    required LatLng location,
    required String email,
    required String number,
  }) async {
    List<MultipartFile> files = [];
    for (var path in paths) {
      if (path != null) {
        final mpFile =
            await MultipartFile.fromFile(path, filename: basename(path));
        files.add(mpFile);
      }
    }

    try {
      FormData formData = FormData.fromMap({
        'email': email,
        'phone': number,
        'comment': comment,
        'problem_type': type,
        'geo_location': [location.latitude, location.longitude],
        'status': 'На рассмотрении',
        'user_id': '${getUser()!.id}',
        'photos': files,
      });
      await dio.post(
        '$_baseURL/incedentreport',
        data: formData,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String secondName,
    required String thirdName,
    required String gender,
    required DateTime birthday,
    required String citizenship,
    required String passport,
    required String region,
  }) async {
    try {
      final data = {
        'email': email,
        'password': password,
        'name': firstName,
        'sname': secondName,
        'fname': thirdName,
        'birthday': '${birthday.day}.${birthday.month}.${birthday.year}',
        'nationality': citizenship,
        'registration_region': region,
        'sex': gender,
        'passport': passport,
      };
      await dio.post(
        '$_baseURL/register',
        data: data,
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
