import 'package:flutter/material.dart';
import 'package:volunteer_linker/constants/app_colors.dart';

class KeywordsSelection extends StatefulWidget {
  final List<String> keywords;
  final String title;
  final bool canEdit;

  const KeywordsSelection({
    super.key,
    required this.keywords,
    required this.title,
    this.canEdit = false,
  });

  @override
  _KeywordsSelectionState createState() => _KeywordsSelectionState();
}

class _KeywordsSelectionState extends State<KeywordsSelection> {
  List<String> selectedKeywords = [];
  bool isEditMode = false;

  void _toggleKeyword(String keyword) {
    setState(() {
      if (selectedKeywords.contains(keyword)) {
        selectedKeywords.remove(keyword);
      } else {
        selectedKeywords.add(keyword);
      }
    });
  }

  void _toggleEditMode() {
    setState(() {
      isEditMode = !isEditMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.canEdit)
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(isEditMode ? Icons.check : Icons.edit),
              onPressed: _toggleEditMode,
            ),
          ),
        if (isEditMode && widget.canEdit)
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: widget.keywords.map((keyword) {
              final bool isSelected = selectedKeywords.contains(keyword);
              return FilterChip(
                label: Text(keyword),
                selected: isSelected,
                onSelected: (bool selected) {
                  _toggleKeyword(keyword);
                },
                selectedColor: AppColors.greyColor,
                backgroundColor: AppColors.backgroundColor,
                checkmarkColor: AppColors.primaryIconColor,
              );
            }).toList(),
          ),
        Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: selectedKeywords.map((keyword) {
            return Chip(
              label: Text(keyword),
              deleteIcon: isEditMode ? const Icon(Icons.cancel) : null,
              onDeleted: isEditMode
                  ? () {
                      _toggleKeyword(keyword);
                    }
                  : null,
            );
          }).toList(),
        ),
      ],
    );
  }
}
