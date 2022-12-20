// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionModelAdapter extends TypeAdapter<TransactionModel> {
  @override
  final int typeId = 3;

  @override
  TransactionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionModel(
      data: (fields[0] as List?)?.cast<TransactionsDatum>(),
      errorCode: fields[1] as int?,
      errorNote: fields[2] as String?,
      status: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionModel obj) {
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
      other is TransactionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TransactionsDatumAdapter extends TypeAdapter<TransactionsDatum> {
  @override
  final int typeId = 4;

  @override
  TransactionsDatum read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionsDatum(
      commissionSum: fields[0] as num?,
      operationTime: fields[1] as String?,
      receiver: fields[2] as Receiver?,
      sender: fields[3] as Receiver?,
      status: fields[4] as String?,
      sum: fields[5] as num?,
      templateId: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionsDatum obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.commissionSum)
      ..writeByte(1)
      ..write(obj.operationTime)
      ..writeByte(2)
      ..write(obj.receiver)
      ..writeByte(3)
      ..write(obj.sender)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.sum)
      ..writeByte(6)
      ..write(obj.templateId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionsDatumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReceiverAdapter extends TypeAdapter<Receiver> {
  @override
  final int typeId = 5;

  @override
  Receiver read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Receiver(
      bankCode: fields[0] as String?,
      expire: fields[1] as String?,
      id: fields[2] as String?,
      owner: fields[3] as String?,
      pan: fields[4] as String?,
      psCode: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Receiver obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.bankCode)
      ..writeByte(1)
      ..write(obj.expire)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.owner)
      ..writeByte(4)
      ..write(obj.pan)
      ..writeByte(5)
      ..write(obj.psCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReceiverAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
