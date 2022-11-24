import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newswire/=models=/news_item.dart';
import 'package:newswire/ui/constants.dart';
import 'package:newswire/ui/utils.dart';

class NewsItemPanel extends StatelessWidget {
  final NewsItem newsItem;

  const NewsItemPanel({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    final imgUrl = newsItem.thumbnailStandard ?? '';
    final title = (newsItem.title.isNotEmpty)
        ? newsItem.title
        : '[ ${newsItem.itemType} ]';
    final subtitle = (newsItem.subsection.isNotEmpty)
        ? '${newsItem.section} / ${newsItem.subsection}'
        : newsItem.section;

    return InkWell(
      onTap: () => launchUrlInApp(newsItem.url),
      child: Ink(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 2, color: Colors.indigo.shade100),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 14),
                imgUrl.isEmpty
                    ? const _ImagePlaceholder()
                    : CachedNetworkImage(
                        imageUrl: imgUrl,
                        width: kPreviewImgSideSize,
                        height: kPreviewImgSideSize,
                        placeholder: (_, __) => const _ImagePlaceholder(),
                        errorWidget: (_, __, ___) => const _ImageError()),
                const SizedBox(width: 14),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blueGrey[700]),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: Colors.blueGrey[500]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat('dd.MM.yyyy  HH:mm')
                              .format(newsItem.publishedDate),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xFF7986CB)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          )),
    );
  }
}

//-------------------

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, //Colors.green.shade50,
      width: kPreviewImgSideSize,
      height: kPreviewImgSideSize,
      child: Center(
          child: Icon(
        Icons.newspaper,
        size: 30,
        color: Colors.grey.shade300,
      )),
    );
  }
}

class _ImageError extends StatelessWidget {
  const _ImageError();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, //Colors.green.shade50,
      width: kPreviewImgSideSize,
      height: kPreviewImgSideSize,
      child: Center(
          child: Icon(
        Icons.error,
        size: 30,
        color: Colors.red.shade200,
      )),
    );
  }
}
