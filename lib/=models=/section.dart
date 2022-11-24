import 'package:equatable/equatable.dart';

class Section with EquatableMixin {
  const Section({
    required this.section,
    required this.displayName,
  });

  final String section;
  final String displayName;

  @override
  List<Object?> get props => [
        section,
        displayName,
      ];

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        section: json['section'],
        displayName: json['display_name'],
      );
}
