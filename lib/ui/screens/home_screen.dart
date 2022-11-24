import 'package:flutter/material.dart';
import 'package:newswire/ui/widgets/home_screen/news_list.dart';
import 'package:newswire/ui/widgets/home_screen/paged_news_list.dart';
import 'package:newswire/ui/widgets/home_screen/search_bar.dart';
import 'package:newswire/ui/widgets/home_screen/sections_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final PageStorageBucket bucket = PageStorageBucket();
  late final TabController _controller;
  int _currentIndex = 1;

  @override
  void initState() {
    _controller = TabController(vsync: this, length: 2);
    _controller.index = _currentIndex;
    _controller.addListener(() {
      if (_controller.index == 0) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
      setState(() {
        _currentIndex = _controller.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        bottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.list),
                  SizedBox(width: 12),
                  Text('Simple list'),
                  SizedBox(width: 6),
                ],
              ),
            ),
            Tab(
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.smart_button),
                  SizedBox(width: 12),
                  Text('Smart list'),
                  SizedBox(width: 6),
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
        title: const Text('Times Newswire'),
        actions: (_currentIndex == 1)
            ? [IconButton(onPressed: () {}, icon: const Icon(Icons.settings))]
            : null,
      ),
      body: PageStorage(
        bucket: bucket,
        child: TabBarView(
          controller: _controller,
          children: [
            // Вкладка "Simple list"
            const NewsList(
              key: PageStorageKey('SimlpeListPage'),
            ),
            // Вкладка "Smart list"
            Column(
              key: const PageStorageKey('SmartListPage'),
              children: const [
                SectionsBar(),
                SearchBar(),
                Expanded(child: PagedNewsList()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
