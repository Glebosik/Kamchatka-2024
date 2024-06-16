// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';
import 'package:uni_table/data/models/trail.dart';

part 'oopt.g.dart';

@HiveType(typeId: 1)
class Oopt extends Equatable with HiveObjectMixin {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<LatLng> border;
  @HiveField(2)
  final String? authorizedRoutes;
  @HiveField(3)
  final String? activities;
  @HiveField(4)
  final String? security;
  @HiveField(5)
  final String? animals;
  @HiveField(6)
  final String? docsRules;
  @HiveField(7)
  final String? pets;
  @HiveField(8)
  final String? infrastructure;
  @HiveField(9)
  final String? howToGetTo;
  @HiveField(10)
  final String? howWorks;
  @HiveField(11)
  final String? firstAid;
  @HiveField(12)
  final String? science;
  @HiveField(13)
  final String? unauthorizedRoutes;
  @HiveField(14)
  final String? about;
  @HiveField(15)
  final String? office;
  @HiveField(16)
  final String? securityFees;
  @HiveField(17)
  final String? snowcrawlerRules;
  @HiveField(18)
  final String? skiRules;
  @HiveField(19)
  final String? nature;
  @HiveField(20)
  final String? connectivity;
  @HiveField(21)
  final String? gear;
  @HiveField(22)
  final String? unesco;
  @HiveField(23)
  final String? emergency;
  @HiveField(24)
  final List<Trail> trails;

  Oopt({
    this.authorizedRoutes,
    this.activities,
    this.security,
    this.animals,
    this.docsRules,
    this.pets,
    this.infrastructure,
    this.howToGetTo,
    this.howWorks,
    this.firstAid,
    this.science,
    this.unauthorizedRoutes,
    this.about,
    this.office,
    this.securityFees,
    this.snowcrawlerRules,
    this.skiRules,
    this.nature,
    this.connectivity,
    this.gear,
    this.unesco,
    this.emergency,
    required this.name,
    required this.border,
    required this.trails,
  });

  @override
  String toString() {
    return name;
  }

  @override
  List<Object?> get props => [name];
}
