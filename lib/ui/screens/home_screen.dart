import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newswire/logic/news_cubit.dart';
import 'package:newswire/ui/widgets/home_screen/news_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Times Newswire'),
          actions: [
            IconButton(
              onPressed: context.read<NewsCubit>().getNews,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: const NewsList());
  }
}
