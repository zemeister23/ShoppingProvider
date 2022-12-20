// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loans_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoansModelAdapter extends TypeAdapter<LoansModel> {
  @override
  final int typeId = 13;

  @override
  LoansModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoansModel(
      data: (fields[0] as List?)?.cast<LoansDatumm>(),
      errorCode: fields[1] as int?,
      errorNote: fields[2] as String?,
      status: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LoansModel obj) {
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
      other is LoansModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LoansDatummAdapter extends TypeAdapter<LoansDatumm> {
  @override
  final int typeId = 14;

  @override
  LoansDatumm read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoansDatumm(
      amount: fields[0] as num?,
      closeData: fields[1] as String?,
      currency: fields[2] as String?,
      graphAmount: fields[3] as num?,
      graphDay: fields[4] as String?,
      name: fields[5] as String?,
      rate: fields[6] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, LoansDatumm obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.closeData)
      ..writeByte(2)
      ..write(obj.currency)
      ..writeByte(3)
      ..write(obj.graphAmount)
      ..writeByte(4)
      ..write(obj.graphDay)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.rate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoansDatummAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
