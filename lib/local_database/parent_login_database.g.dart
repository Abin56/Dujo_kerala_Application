// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_login_database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DBParentLoginAdapter extends TypeAdapter<DBParentLogin> {
  @override
  final int typeId = 1;

  @override
  DBParentLogin read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DBParentLogin(
      schoolID: fields[0] as String,
      batchID: fields[1] as String,
      classID: fields[2] as String,
      studentID: fields[3] as String,
      studentName: fields[4] as String?,
      parentID: fields[5] as String,
      emailID: fields[6] as String,
      parentDocID: fields[7] as String,
      parentEmail: fields[8] as String,
      parentPassword: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DBParentLogin obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.schoolID)
      ..writeByte(1)
      ..write(obj.batchID)
      ..writeByte(2)
      ..write(obj.classID)
      ..writeByte(3)
      ..write(obj.studentID)
      ..writeByte(4)
      ..write(obj.studentName)
      ..writeByte(5)
      ..write(obj.parentID)
      ..writeByte(6)
      ..write(obj.emailID)
      ..writeByte(7)
      ..write(obj.parentDocID)
      ..writeByte(8)
      ..write(obj.parentEmail)
      ..writeByte(9)
      ..write(obj.parentPassword);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DBParentLoginAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
