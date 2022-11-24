import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newswire/=models=/section.dart';
import 'package:newswire/logic/news_cubit.dart';

class SectionItemTile extends StatefulWidget {
  final Section section;

  const SectionItemTile({Key? key, required this.section}) : super(key: key);

  @override
  State<SectionItemTile> createState() => _SectionItemTileState();
}

class _SectionItemTileState extends State<SectionItemTile> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: InkWell(
        onTap: () {
          //print(widget.section.displayName);
          setState(() {
            isSelected = !isSelected;
          });
          if (isSelected) {
            context
                .read<NewsCubit>()
                .addSectionToFilter(section: widget.section);
          } else {
            context
                .read<NewsCubit>()
                .removeSectionFromFilter(section: widget.section);
          }
        },
        borderRadius: BorderRadius.circular(15),
        child: Ink(
          //width: 100,
          height: 27,
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.indigo.withOpacity(0.4)
                : Colors.indigo.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15),
            border:
                isSelected ? Border.all(color: Colors.indigo, width: 2) : null,
          ),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              widget.section.displayName,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
            ),
          )),
        ),
      ),
    );
  }
}
