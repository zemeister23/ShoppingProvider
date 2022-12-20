// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acounts_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountsModelAdapter extends TypeAdapter<AccountsModel> {
  @override
  final int typeId = 6;

  @override
  AccountsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountsModel(
      data: (fields[0] as List?)?.cast<AccountsDatum>(),
      errorCode: fields[1] as int?,
      errorNote: fields[2] as String?,
      status: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AccountsModel obj) {
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
      other is AccountsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AccountsDatumAdapter extends TypeAdapter<AccountsDatum> {
  @override
  final int typeId = 7;

  @override
  AccountsDatum read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountsDatum(
      account: fields[0] as String?,
      codeCoa: fields[1] as String?,
      codeCurrency: fields[2] as String?,
      codeFilial: fields[3] as String?,
      condition: fields[4] as String?,
      createDate: fields[5] as String?,
      id: fields[6] as String?,
      nameAcc: fields[7] as String?,
      saldo: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AccountsDatum obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.account)
      ..writeByte(1)
      ..write(obj.codeCoa)
      ..writeByte(2)
      ..write(obj.codeCurrency)
      ..writeByte(3)
      ..write(obj.codeFilial)
      ..writeByte(4)
      ..write(obj.condition)
      ..writeByte(5)
      ..write(obj.createDate)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.nameAcc)
      ..writeByte(8)
      ..write(obj.saldo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountsDatumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
