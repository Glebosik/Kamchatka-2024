// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:kamchatka/src/models/oopt.dart';
import 'package:kamchatka/src/models/user.dart';

part 'application.g.dart';

@HiveType(typeId: 2)
class Application extends Equatable with HiveObjectMixin {
  @HiveField(0)
  final Oopt oopt;
  @HiveField(1)
  final User user;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final String eventPurpose;
  @HiveField(4)
  final String eventFormat;
  @HiveField(5)
  final String media;
  @HiveField(6)
  final String email;
  @HiveField(7)
  final String number;
  @HiveField(8)
  final String status;

  Application({
    required this.status,
    required this.oopt,
    required this.user,
    required this.date,
    required this.eventPurpose,
    required this.eventFormat,
    required this.media,
    required this.email,
    required this.number,
  });

  @override
  List<Object?> get props => [
        oopt,
        user,
        date,
        eventPurpose,
        eventFormat,
        media,
        email,
        number,
        status
      ];
}
