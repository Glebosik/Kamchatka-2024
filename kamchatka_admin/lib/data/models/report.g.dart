// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReportAdapter extends TypeAdapter<Report> {
  @override
  final int typeId = 6;

  @override
  Report read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Report(
      id: fields[0] as int,
      comment: fields[1] as String,
      geo_location: fields[2] as LatLng,
      status: fields[3] as String,
      photos: (fields[4] as List).cast<String>(),
      problem_type: fields[5] as String,
      email: fields[6] as String,
      phone: fields[7] as String,
      user: fields[8] as User,
    );
  }

  @override
  void write(BinaryWriter writer, Report obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.comment)
      ..writeByte(2)
      ..write(obj.geo_location)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.photos)
      ..writeByte(5)
      ..write(obj.problem_type)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
