import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:newswire/logic/news_cubit.dart';
import 'package:newswire/ui/constants.dart';
import 'package:newswire/ui/widgets/home_screen/news_item_tile.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsState = context.watch<NewsCubit>().state;

    switch (newsState.status) {
      case XStatus.initial:
        return const SizedBox.shrink();
      //---
      case XStatus.inProgress:
        return const Center(child: CircularProgressIndicator());
      //---
      case XStatus.failure:
        //return ErrorMessage(messageText: newsState.errorMessage);
        return Text(newsState.errorMessage ?? 'Error');
      //---
      case XStatus.success:
      case XStatus.filterSuccess:
    }

    final news = newsState.news;

    if (news.isEmpty) {
      return const Center(
        child: Text('There is no news...', style: TextStyle(fontSize: 18)),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<NewsCubit>().toInitial();
        context.read<NewsCubit>().getNews();
      },
      child: ListView.separated(
          itemCount: news.length,
          itemBuilder: (_, index) => NewsItemTile(newsItem: news[index]),
          separatorBuilder: (_, __) =>
              // Container(color: Colors.grey[350], height: 2),
              // Лучше использовать const SizedBox вместо контейнера,
              // т.к. у контейнера нет const-конструктора
              const SizedBox(
                height: 2,
                child: DecoratedBox(
                    decoration:
                        BoxDecoration(color: Color(clrListTileSeparator))),
              )),
    );
  }
}
