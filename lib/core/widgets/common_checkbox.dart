import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class CommonCheckBox extends StatelessWidget {
  final String label;
  final Function(bool?) onValueChanged;
  final bool isChecked;

  const CommonCheckBox({
    Key? key,
    required this.label,
    required this.onValueChanged,
    required this.isChecked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 2,
            right: 8,
            bottom: 27,
          ),
          child: Theme(
            data: ThemeData(
              unselectedWidgetColor: AppColors.borderSecondaryColor,
            ),
            child: SizedBox(
              height: 12,
              width: 12,
              child: Checkbox(
                value: isChecked,
                onChanged: onValueChanged,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 41,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontStyle: FontStyle.italic,
              fontFamily: 'EB Garamond',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        )
      ],
    );
  }
}
