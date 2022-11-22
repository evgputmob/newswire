import 'package:equatable/equatable.dart';

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

  final String url;
  final String format;
  final int height;
  final int width;
  final String type;
  final String subtype;
  final String caption;
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
