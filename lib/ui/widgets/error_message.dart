import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newswire/logic/news_cubit.dart';
import 'package:newswire/logic/sections_cubit.dart';

class ErrorMessage extends StatelessWidget {
  final String? messageText;

  const ErrorMessage({Key? key, required this.messageText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity),
        const Text(
          'Error ',
          style: TextStyle(
            fontSize: 17,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 14),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: SizedBox(
            width: 300,
            child: Text(
              messageText ?? 'Something went wrong',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[800],
              ),
            ),
          ),
        ),
        const SizedBox(height: 22),
        ElevatedButton(
          child: const Text(
            'Try again',
            style: TextStyle(fontSize: 16),
          ),
          onPressed: () {
            context.read<SectionsCubit>().getSections();
            context.read<NewsCubit>().getNews();
          },
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
