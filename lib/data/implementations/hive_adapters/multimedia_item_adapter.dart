import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:newswire/=models=/multimedia_item.dart';

class MultimediaItemAdapter extends TypeAdapter<MultimediaItem>
    with EquatableMixin {
  @override
  final int typeId = 2;

  @override
  MultimediaItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MultimediaItem(
      url: fields[0] as String,
      format: fields[1] as String,
      height: fields[2] as int,
      width: fields[3] as int,
      type: fields[4] as String,
      subtype: fields[5] as String,
      caption: fields[6] as String,
      copyright: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MultimediaItem obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.format)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.width)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.subtype)
      ..writeByte(6)
      ..write(obj.caption)
      ..writeByte(7)
      ..write(obj.copyright);
  }

  @override
  List<Object?> get props => [typeId];
}
