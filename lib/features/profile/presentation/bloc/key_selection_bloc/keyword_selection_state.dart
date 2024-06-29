part of 'keyword_selection_bloc.dart';

class KeywordSelectionState extends Equatable {
  final List<String> selectedKeywords;
  final bool isEditMode;

  const KeywordSelectionState({
    this.selectedKeywords = const [],
    this.isEditMode = false,
  });

  @override
  List<Object> get props => [selectedKeywords, isEditMode];

  copywith({
    List<String>? selectedKeywords,
    bool? isEditMode,
  }) {
    return KeywordSelectionState(
      selectedKeywords: selectedKeywords ?? this.selectedKeywords,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }


  bool isSelected(String keyword) {
    return selectedKeywords.contains(keyword);
  }
}
