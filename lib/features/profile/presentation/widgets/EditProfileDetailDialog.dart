import 'package:flutter/material.dart';

class EditSubtitleDialog extends StatelessWidget {
  final String initialValue;
  final Function(String) onSave;
  final String title;

  const EditSubtitleDialog({
    super.key,
    required this.initialValue,
    required this.onSave,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller =
        TextEditingController(text: initialValue);

    return AlertDialog(
      title: Text('Edit $title'),
      content: TextField(
        controller: controller,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Enter new $title',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('SAVE'),
          onPressed: () {
            onSave(controller.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
