// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'p2p_template_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class P2PTemplatesModelAdapter extends TypeAdapter<P2PTemplatesModel> {
  @override
  final int typeId = 8;

  @override
  P2PTemplatesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return P2PTemplatesModel(
      data: (fields[0] as List?)?.cast<P2pTemplatesDatum>(),
      errorCode: fields[1] as int?,
      errorNote: fields[2] as String?,
      status: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, P2PTemplatesModel obj) {
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
      other is P2PTemplatesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class P2pTemplatesDatumAdapter extends TypeAdapter<P2pTemplatesDatum> {
  @override
  final int typeId = 9;

  @override
  P2pTemplatesDatum read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return P2pTemplatesDatum(
      commissionSum: fields[0] as num?,
      operationTime: fields[1] as String?,
      receiver: fields[2] as P2pReceiver?,
      sender: fields[3] as P2pReceiver?,
      status: fields[4] as String?,
      sum: fields[5] as num?,
      templateId: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, P2pTemplatesDatum obj) {
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
      other is P2pTemplatesDatumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class P2pReceiverAdapter extends TypeAdapter<P2pReceiver> {
  @override
  final int typeId = 10;

  @override
  P2pReceiver read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return P2pReceiver(
      bankCode: fields[0] as String?,
      expire: fields[1] as String?,
      id: fields[2] as String?,
      owner: fields[3] as String?,
      pan: fields[4] as String?,
      psCode: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, P2pReceiver obj) {
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
      other is P2pReceiverAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
