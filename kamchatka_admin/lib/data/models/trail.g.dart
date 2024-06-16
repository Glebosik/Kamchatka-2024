// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrailAdapter extends TypeAdapter<Trail> {
  @override
  final int typeId = 4;

  @override
  Trail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Trail(
      name: fields[0] as String,
      time: fields[1] as int,
      distance: fields[2] as double,
      wayOfTravel: fields[3] as String,
      months: fields[4] as String,
      points: (fields[5] as List).cast<Geopoint>(),
    );
  }

  @override
  void write(BinaryWriter writer, Trail obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.distance)
      ..writeByte(3)
      ..write(obj.wayOfTravel)
      ..writeByte(4)
      ..write(obj.months)
      ..writeByte(5)
      ..write(obj.points);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
