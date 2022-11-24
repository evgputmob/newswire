import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newswire/logic/sections_cubit.dart';
import 'package:newswire/ui/widgets/home_screen/section_item_tile.dart';

class SectionsList extends StatelessWidget {
  const SectionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final sectionsState = context.watch<SectionsCubit>().state;

    switch (sectionsState.status) {
      case SecXStatus.initial:
        return const SizedBox.shrink();
      //---
      case SecXStatus.inProgress:
        return const Center(
          child: Opacity(
            opacity: 0.5,
            child: SizedBox(
                width: 20, height: 20, child: CircularProgressIndicator()),
          ),
        );
      //---
      case SecXStatus.failure:
        return SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: TextOneLine(
                sectionsState.errorMessage ?? 'Error',
                style: TextStyle(color: Colors.red.shade300),
              ),
            ));
      //---
      case SecXStatus.success:
    }

    final sections = sectionsState.sections;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            for (var section in sections) SectionItemTile(section: section)
          ],
        ),
      ),
    );
  }
}
