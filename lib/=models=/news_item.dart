import 'package:equatable/equatable.dart';
import 'related_url.dart';
import 'multimedia_item.dart';

class NewsItem with EquatableMixin {
  const NewsItem({
    required this.slugName,
    required this.section,
    required this.subsection,
    required this.title,
    required this.newsAbstract,
    required this.uri,
    required this.url,
    required this.byline,
    required this.thumbnailStandard,
    required this.itemType,
    required this.source,
    required this.updatedDate,
    required this.createdDate,
    required this.publishedDate,
    required this.firstPublishedDate,
    required this.materialTypeFacet,
    required this.kicker,
    required this.subheadline,
    required this.desFacet,
    required this.orgFacet,
    required this.perFacet,
    required this.geoFacet,
    required this.relatedUrls,
    required this.multimedia,
  });

  final String slugName;
  final String section;
  final String subsection;
  final String title;
  final String newsAbstract;
  final String uri;
  final String url;
  final String byline;
  final String? thumbnailStandard;
  final String itemType;
  final String source;
  final DateTime updatedDate;
  final DateTime createdDate;
  final DateTime publishedDate;
  final DateTime firstPublishedDate;
  final String materialTypeFacet;
  final String kicker;
  final String subheadline;
  final List<String>? desFacet;
  final List<String>? orgFacet;
  final List<String>? perFacet;
  final List<String>? geoFacet;
  final List<RelatedUrl>? relatedUrls;
  final List<MultimediaItem>? multimedia;

  @override
  List<Object?> get props => [
        slugName,
        section,
        subsection,
        title,
        newsAbstract,
        uri,
        url,
        byline,
        thumbnailStandard,
        itemType,
        source,
        updatedDate,
        createdDate,
        publishedDate,
        firstPublishedDate,
        materialTypeFacet,
        kicker,
        subheadline,
        desFacet,
        orgFacet,
        perFacet,
        geoFacet,
        relatedUrls,
        multimedia,
      ];

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    //print(json['slug_name']);

    return NewsItem(
      slugName: json['slug_name'],
      section: json['section'],
      subsection: json['subsection'],
      title: json['title'],
      newsAbstract: json['abstract'],
      uri: json['uri'],
      url: json['url'],
      byline: json['byline'],
      thumbnailStandard: json['thumbnail_standard'],
      itemType: json['item_type'],
      source: json['source'],
      updatedDate: DateTime.parse(json['updated_date']),
      createdDate: DateTime.parse(json['created_date']),
      publishedDate: DateTime.parse(json['published_date']),
      firstPublishedDate: DateTime.parse(json['first_published_date']),
      materialTypeFacet: json['material_type_facet'],
      kicker: json['kicker'],
      subheadline: json['subheadline'],
      desFacet: (json['des_facet'] != null)
          ? List<String>.from(json['des_facet'].map((x) => x))
          : null,
      orgFacet: (json['org_facet'] != null)
          ? List<String>.from(json['org_facet'].map((x) => x))
          : null,
      perFacet: (json['per_facet'] != null)
          ? List<String>.from(json['per_facet'].map((x) => x))
          : null,
      geoFacet: (json['geo_facet'] != null)
          ? List<String>.from(json['geo_facet'].map((x) => x))
          : null,
      relatedUrls: (json['related_urls'] != null)
          ? List<RelatedUrl>.from(
              json['related_urls'].map((x) => RelatedUrl.fromJson(x)))
          : null,
      multimedia: (json['multimedia'] != null)
          ? List<MultimediaItem>.from(
              json['multimedia'].map((x) => MultimediaItem.fromJson(x)))
          : null,
    );
  }

  // Map<String, dynamic> toJson() => {
  //       'slug_name': slugName,
  //       'section': section,
  //       'subsection': subsection,
  //       'title': title,
  //       'abstract': newsAbstract,
  //       'uri': uri,
  //       'url': url,
  //       'byline': byline,
  //       'thumbnail_standard': thumbnailStandard,
  //       'item_type': itemType,
  //       'source': source,
  //       'updated_date': updatedDate.toIso8601String(),
  //       'created_date': createdDate.toIso8601String(),
  //       'published_date': publishedDate.toIso8601String(),
  //       'first_published_date': firstPublishedDate.toIso8601String(),
  //       'material_type_facet': materialTypeFacet,
  //       'kicker': kicker,
  //       'subheadline': subheadline,
  //       'des_facet': List<dynamic>.from(desFacet.map((x) => x)),
  //       'org_facet': orgFacet,
  //       'per_facet': List<dynamic>.from(perFacet.map((x) => x)),
  //       'geo_facet': geoFacet,
  //       'related_urls': relatedUrls,
  //       'multimedia': List<dynamic>.from(multimedia.map((x) => x.toJson())),
  //     };
}
