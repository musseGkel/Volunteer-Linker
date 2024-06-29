import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer_linker/constants/app_colors.dart';
import 'package:volunteer_linker/features/profile/presentation/bloc/key_selection_bloc/keyword_selection_bloc.dart';

class KeywordsSelection extends StatelessWidget {
  final List<String> keywords;
  final String title;
  final bool canEdit;
  final Function(List<String> selectedKeywords)? onSave;
  const KeywordsSelection({
    super.key,
    required this.keywords,
    required this.title,
    this.canEdit = false,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeywordSelectionBloc, KeywordSelectionState>(
      builder: (context, state) {
        return Column(
          children: [
            if (canEdit)
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(state.isEditMode ? Icons.check : Icons.edit),
                  onPressed: () {
                    if (state.isEditMode) {
                      onSave!(state.selectedKeywords);
                    }

                    BlocProvider.of<KeywordSelectionBloc>(context).add(
                      ToggleEditMode(
                        state: state,
                      ),
                    );
                  },
                ),
              ),
            if (state.isEditMode && canEdit)
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: keywords.map((keyword) {
                  return FilterChip(
                    label: Text(keyword),
                    selected: state.isSelected(keyword),
                    onSelected: (bool selected) {
                      BlocProvider.of<KeywordSelectionBloc>(context).add(
                        ToggleKeyword(
                          state: state,
                          keyword: keyword,
                        ),
                      );
                    },
                    selectedColor: AppColors.greyColor,
                    backgroundColor: AppColors.backgroundColor,
                    checkmarkColor: AppColors.primaryIconColor,
                  );
                }).toList(),
              ),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: state.selectedKeywords.map(
                (keyword) {
                  return Chip(
                    label: Text(keyword),
                    deleteIcon:
                        state.isEditMode ? const Icon(Icons.cancel) : null,
                    onDeleted: state.isEditMode
                        ? () {
                            BlocProvider.of<KeywordSelectionBloc>(context).add(
                              ToggleKeyword(
                                state: state,
                                keyword: keyword,
                              ),
                            );
                          }
                        : null,
                  );
                },
              ).toList(),
            ),
          ],
        );
      },
    );
  }
}
