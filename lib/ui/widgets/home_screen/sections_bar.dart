import 'package:flutter/material.dart';
import 'package:newswire/ui/widgets/home_screen/sections_list.dart';

class SectionsBar extends StatelessWidget {
  const SectionsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 57,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(width: 3, color: Colors.transparent),
          bottom: BorderSide(
            width: 4,
            color: Colors.indigo.shade200.withOpacity(0.6),
          ),
        ),
        color: Colors.indigo.shade50,
      ),
      child: const SectionsList(),
    );
  }
}
