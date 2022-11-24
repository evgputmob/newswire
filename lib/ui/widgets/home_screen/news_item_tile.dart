import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newswire/=models=/news_item.dart';
import 'package:newswire/ui/constants.dart';
import 'package:newswire/ui/utils.dart';

class NewsItemTile extends StatelessWidget {
  final NewsItem newsItem;

  const NewsItemTile({Key? key, required this.newsItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imgUrl = newsItem.thumbnailStandard ?? '';
    final title = (newsItem.title.isNotEmpty)
        ? newsItem.title
        : '[ ${newsItem.itemType} ]';
    final subtitle = (newsItem.subsection.isNotEmpty)
        ? '${newsItem.section} / ${newsItem.subsection}'
        : newsItem.section;

    return ListTile(
      onTap: () => launchUrlInApp(newsItem.url),
      leading: imgUrl.isEmpty
          ? NewsListTileParams.kIconNewspaper
          : CachedNetworkImage(
              imageUrl: imgUrl,
              width: kPreviewImgSideSize,
              height: kPreviewImgSideSize,
              placeholder: (_, __) => NewsListTileParams.kIconNewspaper,
              errorWidget: (_, __, ___) => NewsListTileParams.kIconError,
            ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            //style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 7),
          Text(
            DateFormat('dd.MM.yyyy  HH:mm').format(newsItem.publishedDate),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 12,
                //fontWeight: FontWeight.bold,
                color: Color(0xFF7986CB)),
          ),
        ],
      ),
      isThreeLine: true,
    );
  }
}
