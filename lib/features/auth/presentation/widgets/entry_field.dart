import 'package:flutter/material.dart';

class EntryField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool obscureText;
  const EntryField({
    super.key,
    required this.title,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: title,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xff6941C6),
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
