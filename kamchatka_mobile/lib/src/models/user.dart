// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends Equatable with HiveObjectMixin {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String nameFirst;
  @HiveField(2)
  final String nameSecond;
  @HiveField(3)
  final String nameThird;
  @HiveField(4)
  final DateTime birthday;
  @HiveField(5)
  final String gender;
  @HiveField(6)
  final String nationality;
  @HiveField(7)
  final String region;
  @HiveField(8)
  final String passport;

  User({
    required this.id,
    required this.nameFirst,
    required this.nameSecond,
    required this.nameThird,
    required this.birthday,
    required this.gender,
    required this.nationality,
    required this.region,
    required this.passport,
  });

  Map<String, dynamic> toJson() {
    return {};
  }

  factory User.fromJson(Map<String, dynamic> json) {
    final birthdayList = (json['birthday'] as String)
        .split('.')
        .map((e) => int.parse(e))
        .toList();
    DateTime birthday =
        DateTime(birthdayList[2], birthdayList[1], birthdayList[0]);
    return User(
      id: json['id'],
      nameFirst: json['name'],
      nameSecond: json['sname'],
      nameThird: json['fname'],
      birthday: birthday,
      gender: json['sex'],
      nationality: json['nationality'],
      region: json['registration_region'],
      passport: json['passport'],
    );
  }

  @override
  List<Object?> get props => [
        nameFirst,
        nameSecond,
        nameThird,
        birthday,
        gender,
        nationality,
        region,
        passport,
      ];
}
