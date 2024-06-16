// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oopt.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OoptAdapter extends TypeAdapter<Oopt> {
  @override
  final int typeId = 1;

  @override
  Oopt read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Oopt(
      authorizedRoutes: fields[2] as String?,
      activities: fields[3] as String?,
      security: fields[4] as String?,
      animals: fields[5] as String?,
      docsRules: fields[6] as String?,
      pets: fields[7] as String?,
      infrastructure: fields[8] as String?,
      howToGetTo: fields[9] as String?,
      howWorks: fields[10] as String?,
      firstAid: fields[11] as String?,
      science: fields[12] as String?,
      unauthorizedRoutes: fields[13] as String?,
      about: fields[14] as String?,
      office: fields[15] as String?,
      securityFees: fields[16] as String?,
      snowcrawlerRules: fields[17] as String?,
      skiRules: fields[18] as String?,
      nature: fields[19] as String?,
      connectivity: fields[20] as String?,
      gear: fields[21] as String?,
      unesco: fields[22] as String?,
      emergency: fields[23] as String?,
      name: fields[0] as String,
      border: (fields[1] as List).cast<LatLng>(),
      trails: (fields[24] as List).cast<Trail>(),
    );
  }

  @override
  void write(BinaryWriter writer, Oopt obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.border)
      ..writeByte(2)
      ..write(obj.authorizedRoutes)
      ..writeByte(3)
      ..write(obj.activities)
      ..writeByte(4)
      ..write(obj.security)
      ..writeByte(5)
      ..write(obj.animals)
      ..writeByte(6)
      ..write(obj.docsRules)
      ..writeByte(7)
      ..write(obj.pets)
      ..writeByte(8)
      ..write(obj.infrastructure)
      ..writeByte(9)
      ..write(obj.howToGetTo)
      ..writeByte(10)
      ..write(obj.howWorks)
      ..writeByte(11)
      ..write(obj.firstAid)
      ..writeByte(12)
      ..write(obj.science)
      ..writeByte(13)
      ..write(obj.unauthorizedRoutes)
      ..writeByte(14)
      ..write(obj.about)
      ..writeByte(15)
      ..write(obj.office)
      ..writeByte(16)
      ..write(obj.securityFees)
      ..writeByte(17)
      ..write(obj.snowcrawlerRules)
      ..writeByte(18)
      ..write(obj.skiRules)
      ..writeByte(19)
      ..write(obj.nature)
      ..writeByte(20)
      ..write(obj.connectivity)
      ..writeByte(21)
      ..write(obj.gear)
      ..writeByte(22)
      ..write(obj.unesco)
      ..writeByte(23)
      ..write(obj.emergency)
      ..writeByte(24)
      ..write(obj.trails);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OoptAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
