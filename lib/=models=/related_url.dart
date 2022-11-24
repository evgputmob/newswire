import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

//part 'related_url.g.dart';

@HiveType(typeId: 3)
class RelatedUrl with EquatableMixin {
  const RelatedUrl({
    required this.suggestedLinkText,
    required this.url,
  });

  @HiveField(0)
  final String suggestedLinkText;
  @HiveField(1)
  final String url;

  @override
  List<Object?> get props => [
        suggestedLinkText,
        url,
      ];

  factory RelatedUrl.fromJson(Map<String, dynamic> json) => RelatedUrl(
        suggestedLinkText: json['suggested_link_text'],
        url: json['url'],
      );
}
