// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ID.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IdAdapter extends TypeAdapter<Id> {
  @override
  final int typeId = 3;

  @override
  Id read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Id(
      idNumber: fields[0] as String,
      ExpiryDate: fields[1] as String,
      cardHolderName: fields[2] as String,
      DateOfBirth: fields[3] as String,
      Addres: fields[4] as String,
      Jop: fields[5] as String,
      cardType: fields[6] == null ? 'other ' : fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Id obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.idNumber)
      ..writeByte(1)
      ..write(obj.ExpiryDate)
      ..writeByte(2)
      ..write(obj.cardHolderName)
      ..writeByte(3)
      ..write(obj.DateOfBirth)
      ..writeByte(4)
      ..write(obj.Addres)
      ..writeByte(5)
      ..write(obj.Jop)
      ..writeByte(6)
      ..write(obj.cardType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
