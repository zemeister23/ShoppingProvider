// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_cards_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClientCardsModelAdapter extends TypeAdapter<ClientCardsModel> {
  @override
  final int typeId = 0;

  @override
  ClientCardsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClientCardsModel(
      data: fields[0] as Data?,
      errorCode: fields[1] as int?,
      errorNote: fields[2] as String?,
      status: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ClientCardsModel obj) {
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
      other is ClientCardsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DataAdapter extends TypeAdapter<Data> {
  @override
  final int typeId = 1;

  @override
  Data read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Data(
      cards: (fields[0] as List?)?.cast<Card>(),
      totalSum: fields[1] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, Data obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.cards)
      ..writeByte(1)
      ..write(obj.totalSum);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CardAdapter extends TypeAdapter<Card> {
  @override
  final int typeId = 2;

  @override
  Card read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Card(
      balance: fields[0] as num?,
      cardId: fields[1] as String?,
      cardType: fields[2] as String?,
      expire: fields[3] as String?,
      maskNum: fields[4] as String?,
      mfo: fields[5] as String?,
      owner: fields[6] as String?,
      psCode: fields[7] as String?,
      state: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Card obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.balance)
      ..writeByte(1)
      ..write(obj.cardId)
      ..writeByte(2)
      ..write(obj.cardType)
      ..writeByte(3)
      ..write(obj.expire)
      ..writeByte(4)
      ..write(obj.maskNum)
      ..writeByte(5)
      ..write(obj.mfo)
      ..writeByte(6)
      ..write(obj.owner)
      ..writeByte(7)
      ..write(obj.psCode)
      ..writeByte(8)
      ..write(obj.state);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
