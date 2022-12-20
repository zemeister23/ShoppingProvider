// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposits_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DepositsmodelAdapter extends TypeAdapter<Depositsmodel> {
  @override
  final int typeId = 11;

  @override
  Depositsmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Depositsmodel(
      data: (fields[0] as List?)?.cast<DepositsDatum>(),
      errorCode: fields[1] as int?,
      errorNote: fields[2] as String?,
      status: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Depositsmodel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.errorCode)
      ..writeByte(2)
      ..write(obj.errorNote)
      ..writeByte(3)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DepositsmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DepositsDatumAdapter extends TypeAdapter<DepositsDatum> {
  @override
  final int typeId = 12;

  @override
  DepositsDatum read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DepositsDatum(
      amount: fields[0] as num?,
      closeData: fields[1] as String?,
      currency: fields[2] as String?,
      months: fields[3] as num?,
      name: fields[4] as String?,
      rate: fields[5] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, DepositsDatum obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.closeData)
      ..writeByte(2)
      ..write(obj.currency)
      ..writeByte(3)
      ..write(obj.months)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.rate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DepositsDatumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
