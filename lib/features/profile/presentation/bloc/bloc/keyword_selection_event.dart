part of 'keyword_selection_bloc.dart';

sealed class KeywordSelectionEvent extends Equatable {
  const KeywordSelectionEvent();
  Stream<KeywordSelectionState> handle();

  @override
  List<Object> get props => [];
}

class ToggleEditMode extends KeywordSelectionEvent {
  final KeywordSelectionState state;

  const ToggleEditMode({required this.state});

  @override
  Stream<KeywordSelectionState> handle() async* {
    KeywordSelectionState updatedState = state.copywith(
      isEditMode: !state.isEditMode,
    );
    yield updatedState;
  }
}

class ToggleKeyword extends KeywordSelectionEvent {
  final KeywordSelectionState state;
  final String keyword;

  const ToggleKeyword({
    required this.state,
    required this.keyword,
  });

  @override
  Stream<KeywordSelectionState> handle() async* {
    List<String> updatedKeywords = [...state.selectedKeywords];
    if (state.isSelected(keyword)) {
      updatedKeywords.remove(keyword);
    } else {
      updatedKeywords.add(keyword);
    }
    KeywordSelectionState updatedState = state.copywith(
      selectedKeywords: updatedKeywords,
    );
    yield updatedState;
  }
}
