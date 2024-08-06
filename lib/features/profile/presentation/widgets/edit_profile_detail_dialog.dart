import 'package:flutter/material.dart';

class EditProfileDetailDialog extends StatelessWidget {
  final String initialValue;
  final Function(String) onSave;
  final String title;
  final TextInputType keyboardType;

  const EditProfileDetailDialog({
    super.key,
    required this.initialValue,
    required this.onSave,
    required this.title,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller =
        TextEditingController(text: initialValue);

    return AlertDialog(
      title: Text('Edit $title'),
      content: TextField(
        keyboardType: keyboardType,
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
