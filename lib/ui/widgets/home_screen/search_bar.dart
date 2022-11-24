import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newswire/logic/news_cubit.dart';
import 'package:newswire/ui/constants.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _controllerTextFieldSearch = TextEditingController();

  @override
  void dispose() {
    _controllerTextFieldSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 58,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 4,
            color: Colors.indigo.shade200.withOpacity(0.5),
          ),
        ),
        color: Colors.indigo.shade100,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 1),
        child: Row(
          children: [
            const SizedBox(width: 20),
            const Text(
              'Search:',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _controllerTextFieldSearch,
                onChanged: (value) {
                  context
                      .read<NewsCubit>()
                      .getFilteredNews(filterString: value);
                },
                decoration: kTextFieldDecoration,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),
            const SizedBox(width: 3),
            IconButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                _controllerTextFieldSearch.text = '';
                context.read<NewsCubit>().getFilteredNews(filterString: '');
              },
              icon: const Icon(
                Icons.cancel,
                color: Colors.white,
                size: 26,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
