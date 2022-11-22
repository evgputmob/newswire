import 'package:equatable/equatable.dart';

class RelatedUrl with EquatableMixin {
  const RelatedUrl({
    required this.suggestedLinkText,
    required this.url,
  });

  final String suggestedLinkText;
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
