// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';
import 'package:uni_table/data/models/models.dart';

part 'report.g.dart';

@HiveType(typeId: 6)
class Report extends Equatable with HiveObjectMixin {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String comment;
  @HiveField(2)
  final LatLng geo_location;
  @HiveField(3)
  final String status;
  @HiveField(4)
  final List<String> photos;
  @HiveField(5)
  final String problem_type;
  @HiveField(6)
  final String email;
  @HiveField(7)
  final String phone;
  @HiveField(8)
  final User user;

  Report({
    required this.id,
    required this.comment,
    required this.geo_location,
    required this.status,
    required this.photos,
    required this.problem_type,
    required this.email,
    required this.phone,
    required this.user,
  });

  @override
  List<Object?> get props => [id];
}
