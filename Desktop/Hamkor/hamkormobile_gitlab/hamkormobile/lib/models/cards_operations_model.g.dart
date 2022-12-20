// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cards_operations_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardsOperationsModelAdapter extends TypeAdapter<CardsOperationsModel> {
  @override
  final int typeId = 17;

  @override
  CardsOperationsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardsOperationsModel(
      data: (fields[0] as List?)?.cast<StoryDatum>(),
      errorCode: fields[1] as int?,
      errorNote: fields[2] as String?,
      status: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CardsOperationsModel obj) {
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
      other is CardsOperationsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StoryDatumAdapter extends TypeAdapter<StoryDatum> {
  @override
  final int typeId = 18;

  @override
  StoryDatum read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoryDatum(
      cardId: fields[0] as String?,
      health: fields[1] as bool?,
      operations: (fields[2] as List?)?.cast<HistoryOperation>(),
    );
  }

  @override
  void write(BinaryWriter writer, StoryDatum obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.cardId)
      ..writeByte(1)
      ..write(obj.health)
      ..writeByte(2)
      ..write(obj.operations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryDatumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HistoryOperationAdapter extends TypeAdapter<HistoryOperation> {
  @override
  final int typeId = 19;

  @override
  HistoryOperation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryOperation(
      amount: fields[0] as int?,
      city: fields[1] as String?,
      country: fields[2] as String?,
      currencyCode: fields[3] as String?,
      feeAmount: fields[4] as int?,
      maskPan: fields[5] as String?,
      mccCode: fields[6] as String?,
      merchantName: fields[7] as String?,
      operationDay: fields[8] as String?,
      operationTime: fields[9] as String?,
      operationType: fields[10] as int?,
      orgCode: fields[11] as String?,
      psCode: fields[12] as String?,
      reversal: fields[13] as bool?,
      rrn: fields[14] as String?,
      street: fields[15] as String?,
      terminalId: fields[16] as String?,
      transactionId: fields[17] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HistoryOperation obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.country)
      ..writeByte(3)
      ..write(obj.currencyCode)
      ..writeByte(4)
      ..write(obj.feeAmount)
      ..writeByte(5)
      ..write(obj.maskPan)
      ..writeByte(6)
      ..write(obj.mccCode)
      ..writeByte(7)
      ..write(obj.merchantName)
      ..writeByte(8)
      ..write(obj.operationDay)
      ..writeByte(9)
      ..write(obj.operationTime)
      ..writeByte(10)
      ..write(obj.operationType)
      ..writeByte(11)
      ..write(obj.orgCode)
      ..writeByte(12)
      ..write(obj.psCode)
      ..writeByte(13)
      ..write(obj.reversal)
      ..writeByte(14)
      ..write(obj.rrn)
      ..writeByte(15)
      ..write(obj.street)
      ..writeByte(16)
      ..write(obj.terminalId)
      ..writeByte(17)
      ..write(obj.transactionId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryOperationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
