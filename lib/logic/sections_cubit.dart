import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newswire/=models=/section.dart';
import 'package:newswire/data/i_newswire_service.dart';

enum SecXStatus { initial, inProgress, failure, success }

//------
// State

class SectionsState extends Equatable {
  final SecXStatus status;
  final List<Section> sections;
  final String? errorMessage;

  const SectionsState({
    this.status = SecXStatus.initial,
    this.sections = const [],
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, sections, errorMessage];
}

//------
// Cubit

class SectionsCubit extends Cubit<SectionsState> {
  late final INewswireService _newsService;

  SectionsCubit({required INewswireService newsService})
      : _newsService = newsService,
        super(const SectionsState());

  Future<void> getSections() async {
    emit(const SectionsState(status: SecXStatus.inProgress));
    try {
      final sections = await _newsService.getSections();
      emit(SectionsState(status: SecXStatus.success, sections: sections));
    } catch (e) {
      emit(SectionsState(
          status: SecXStatus.failure, errorMessage: e.toString()));
    }
  }

  void toInitial() {
    emit(const SectionsState(status: SecXStatus.initial));
  }
}
