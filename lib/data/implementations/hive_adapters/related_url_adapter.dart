import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:newswire/=models=/related_url.dart';

class RelatedUrlAdapter extends TypeAdapter<RelatedUrl> with EquatableMixin {
  @override
  final int typeId = 3;

  @override
  RelatedUrl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RelatedUrl(
      suggestedLinkText: fields[0] as String,
      url: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RelatedUrl obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.suggestedLinkText)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  List<Object?> get props => [typeId];
}
