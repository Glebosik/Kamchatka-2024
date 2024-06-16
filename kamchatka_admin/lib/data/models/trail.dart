// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uni_table/data/models/geopoint.dart';

part 'trail.g.dart';

@HiveType(typeId: 4)
class Trail extends Equatable with HiveObjectMixin {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int time;
  @HiveField(2)
  final double distance;
  @HiveField(3)
  final String wayOfTravel;
  @HiveField(4)
  final String months;
  @HiveField(5)
  final List<Geopoint> points;

  Trail({
    required this.name,
    required this.time,
    required this.distance,
    required this.wayOfTravel,
    required this.months,
    required this.points,
  });

  @override
  String toString() {
    return '$name\n$points';
  }

  @override
  List<Object?> get props =>
      [name, time, distance, wayOfTravel, months, points];
}
