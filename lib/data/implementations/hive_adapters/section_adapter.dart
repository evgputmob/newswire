import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:newswire/=models=/section.dart';

class SectionAdapter extends TypeAdapter<Section> with EquatableMixin {
  @override
  final int typeId = 1;

  @override
  Section read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Section(
      section: fields[0] as String,
      displayName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Section obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.section)
      ..writeByte(1)
      ..write(obj.displayName);
  }

  @override
  List<Object?> get props => [typeId];
}
