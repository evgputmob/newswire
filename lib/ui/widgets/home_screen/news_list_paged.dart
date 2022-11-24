import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newswire/=models=/news_item.dart';
import 'package:newswire/logic/news_cubit.dart';
import 'package:newswire/ui/widgets/error_message.dart';
import 'package:newswire/ui/widgets/home_screen/news_item_panel.dart';

class NewsListPaged extends StatefulWidget {
  const NewsListPaged({Key? key}) : super(key: key);

  @override
  State<NewsListPaged> createState() => _NewsListPagedState();
}

class _NewsListPagedState extends State<NewsListPaged>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  static const newsPerPage = 5;
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final newsState = context.watch<NewsCubit>().state;

    List<NewsItem> news = [];

    switch (newsState.status) {
      case XStatus.initial:
        return const SizedBox.shrink();
      //---
      case XStatus.inProgress:
        return const Center(child: CircularProgressIndicator());
      //---
      case XStatus.failure:
        return ErrorMessage(messageText: newsState.errorMessage);
      //return Text(newsState.errorMessage ?? 'Error');
      //---
      case XStatus.success:
      case XStatus.filterSuccess:
        news = newsState.filteredNews;
        break;
    }

    int pagesCount = news.length ~/ newsPerPage;
    if (news.length % newsPerPage > 0) pagesCount++;

    if ((newsState.status == XStatus.filterSuccess) &&
        (_pageIndex > pagesCount - 1)) {
      setState(() {
        _pageIndex = 0;
      });
    }

    final startNewsIndex = _pageIndex * newsPerPage;

    Widget newsContainer(int index) {
      if (index > news.length - 1) {
        return const Expanded(child: SizedBox());
      }
      return Expanded(child: NewsItemPanel(newsItem: news[index]));
    }

    return Column(
      children: [
        Expanded(
          child: Column(children: [
            for (int i = startNewsIndex; i < startNewsIndex + newsPerPage; i++)
              newsContainer(i)
          ]),
        ),
        Ink(
          height: 56,
          width: double.infinity,
          color: Colors.indigo,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 3),
              IconButton(
                onPressed: () {
                  if (_pageIndex >= 1) {
                    setState(() {
                      _pageIndex--;
                    });
                  }
                },
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.white,
              ),
              const SizedBox(width: 30),
              Text(
                (_pageIndex + 1).toString(),
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(width: 36),
              IconButton(
                onPressed: () {
                  if (_pageIndex < pagesCount - 1) {
                    setState(() {
                      _pageIndex++;
                    });
                  }
                },
                icon: const Icon(Icons.arrow_forward_ios),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
