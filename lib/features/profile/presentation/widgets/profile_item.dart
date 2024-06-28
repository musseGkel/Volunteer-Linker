import 'package:flutter/material.dart';
import 'package:volunteer_linker/constants/app_colors.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function()? onEditPressed;

  final bool isOnEditMode;

  const ProfileItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.isOnEditMode = false,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Material(
        elevation: 15,
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 6,
                bottom: 6,
                left: isOnEditMode ? 10 : 10,
                right: isOnEditMode ? 25 : 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: const Border(
                  bottom: BorderSide(
                    color: AppColors.greyColor,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        subtitle,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isOnEditMode)
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: onEditPressed,
                  icon: const Icon(
                    Icons.edit,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
