import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class CommonTextField extends StatelessWidget {
  final String label;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool enabled;
  const CommonTextField({
    super.key,
    required this.label,
    this.onChanged,
    this.controller,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.5),
      child: Column(
        children: [
          TextField(
            enabled: enabled,
            controller: controller,
            onChanged: onChanged,
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                  width: 2.0,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.borderSecondaryColor,
                  width: 1.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 2.5,
              left: 10.5,
            ),
            child: Row(
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontSize: 12,
                    fontFamily: 'EB Garamond',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
