// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_name_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClientNameModelAdapter extends TypeAdapter<ClientNameModel> {
  @override
  final int typeId = 15;

  @override
  ClientNameModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClientNameModel(
      data: fields[0] as ClientNameData?,
      errorCode: fields[1] as int?,
      errorNote: fields[2] as String?,
      status: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ClientNameModel obj) {
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
      other is ClientNameModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ClientNameDataAdapter extends TypeAdapter<ClientNameData> {
  @override
  final int typeId = 16;

  @override
  ClientNameData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClientNameData(
      firstName: fields[0] as String?,
      lastName: fields[1] as String?,
      middleName: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ClientNameData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.middleName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientNameDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
