import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

//part 'multimedia_item.g.dart';

@HiveType(typeId: 2)
class MultimediaItem with EquatableMixin {
  const MultimediaItem({
    required this.url,
    required this.format,
    required this.height,
    required this.width,
    required this.type,
    required this.subtype,
    required this.caption,
    required this.copyright,
  });

  @HiveField(0)
  final String url;
  @HiveField(1)
  final String format;
  @HiveField(2)
  final int height;
  @HiveField(3)
  final int width;
  @HiveField(4)
  final String type;
  @HiveField(5)
  final String subtype;
  @HiveField(6)
  final String caption;
  @HiveField(7)
  final String copyright;

  @override
  List<Object?> get props => [
        url,
        format,
        height,
        width,
        type,
        subtype,
        caption,
        copyright,
      ];

  factory MultimediaItem.fromJson(Map<String, dynamic> json) => MultimediaItem(
        url: json['url'],
        format: json['format'],
        height: json['height'],
        width: json['width'],
        type: json['type'],
        subtype: json['subtype'],
        caption: json['caption'],
        copyright: json['copyright'],
      );

  // Map<String, dynamic> toJson() => {
  //       'url': url,
  //       'format': format,
  //       'height': height,
  //       'width': width,
  //       'type': type,
  //       'subtype': subtype,
  //       'caption': caption,
  //       'copyright': copyright,
  //     };
}
