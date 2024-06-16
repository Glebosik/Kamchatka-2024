// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';

part 'geopoint.g.dart';

@HiveType(typeId: 3)
class Geopoint extends Equatable with HiveObjectMixin {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final LatLng coords;

  Geopoint(
    this.name,
    this.coords,
  );

  @override
  String toString() {
    return '$name - $coords';
  }

  @override
  List<Object?> get props => [name, coords];
}
