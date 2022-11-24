import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:newswire/=models=/multimedia_item.dart';
import 'package:newswire/=models=/news_item.dart';
import 'package:newswire/=models=/related_url.dart';

class NewsItemAdapter extends TypeAdapter<NewsItem> with EquatableMixin {
  @override
  final int typeId = 4;

  @override
  NewsItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsItem(
      slugName: fields[0] as String,
      section: fields[1] as String,
      subsection: fields[2] as String,
      title: fields[3] as String,
      newsAbstract: fields[4] as String,
      uri: fields[5] as String,
      url: fields[6] as String,
      byline: fields[7] as String,
      thumbnailStandard: fields[8] as String?,
      itemType: fields[9] as String,
      source: fields[10] as String,
      updatedDate: fields[11] as DateTime,
      createdDate: fields[12] as DateTime,
      publishedDate: fields[13] as DateTime,
      firstPublishedDate: fields[14] as DateTime,
      materialTypeFacet: fields[15] as String,
      kicker: fields[16] as String,
      subheadline: fields[17] as String,
      desFacet: (fields[18] as List?)?.cast<String>(),
      orgFacet: (fields[19] as List?)?.cast<String>(),
      perFacet: (fields[20] as List?)?.cast<String>(),
      geoFacet: (fields[21] as List?)?.cast<String>(),
      relatedUrls: (fields[22] as List?)?.cast<RelatedUrl>(),
      multimedia: (fields[23] as List?)?.cast<MultimediaItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, NewsItem obj) {
    writer
      ..writeByte(24)
      ..writeByte(0)
      ..write(obj.slugName)
      ..writeByte(1)
      ..write(obj.section)
      ..writeByte(2)
      ..write(obj.subsection)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.newsAbstract)
      ..writeByte(5)
      ..write(obj.uri)
      ..writeByte(6)
      ..write(obj.url)
      ..writeByte(7)
      ..write(obj.byline)
      ..writeByte(8)
      ..write(obj.thumbnailStandard)
      ..writeByte(9)
      ..write(obj.itemType)
      ..writeByte(10)
      ..write(obj.source)
      ..writeByte(11)
      ..write(obj.updatedDate)
      ..writeByte(12)
      ..write(obj.createdDate)
      ..writeByte(13)
      ..write(obj.publishedDate)
      ..writeByte(14)
      ..write(obj.firstPublishedDate)
      ..writeByte(15)
      ..write(obj.materialTypeFacet)
      ..writeByte(16)
      ..write(obj.kicker)
      ..writeByte(17)
      ..write(obj.subheadline)
      ..writeByte(18)
      ..write(obj.desFacet)
      ..writeByte(19)
      ..write(obj.orgFacet)
      ..writeByte(20)
      ..write(obj.perFacet)
      ..writeByte(21)
      ..write(obj.geoFacet)
      ..writeByte(22)
      ..write(obj.relatedUrls)
      ..writeByte(23)
      ..write(obj.multimedia);
  }

  @override
  List<Object?> get props => [typeId];
}
