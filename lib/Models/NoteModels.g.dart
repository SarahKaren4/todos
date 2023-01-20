// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NoteModels.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteModelsAdapter extends TypeAdapter<NoteModels> {
  @override
  final int typeId = 1;

  @override
  NoteModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModels(
      title: fields[0] as String?,
      body: fields[1] as String?,
      isComplete: fields[2] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, NoteModels obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.body)
      ..writeByte(2)
      ..write(obj.isComplete);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
