// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ApplicationAdapter extends TypeAdapter<Application> {
  @override
  final int typeId = 2;

  @override
  Application read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Application(
      status: fields[8] as String,
      oopt: fields[0] as Oopt,
      user: fields[1] as User,
      date: fields[2] as DateTime,
      eventPurpose: fields[3] as String,
      eventFormat: fields[4] as String,
      media: fields[5] as String,
      email: fields[6] as String,
      number: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Application obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.oopt)
      ..writeByte(1)
      ..write(obj.user)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.eventPurpose)
      ..writeByte(4)
      ..write(obj.eventFormat)
      ..writeByte(5)
      ..write(obj.media)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.number)
      ..writeByte(8)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApplicationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
