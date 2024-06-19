import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class CommonDropDown extends StatelessWidget {
  final String title;
  final bool isLoading;
  const CommonDropDown(
      {super.key, required this.title, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.secondaryTextColor,
                      fontSize: 12,
                      fontFamily: 'EB Garamond',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                isLoading
                    ? const SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          color: AppColors.borderSecondaryColor,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(
                        Icons.keyboard_arrow_down,
                      ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            color: AppColors.borderSecondaryColor,
          ),
        ],
      ),
    );
  }
}
