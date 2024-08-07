import 'package:flutter/material.dart';
import 'package:volunteer_linker/constants/app_colors.dart';
import 'package:volunteer_linker/core/enums.dart';
import 'package:volunteer_linker/features/profile/presentation/widgets/edit_profile_detail_dialog.dart';

class ProfileDetail extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function(String)? onEditPressed;
  final bool isOnEditMode;
  final Function()? onTap;
  final ProfileDetailEditType editType;
  final TextInputType keyboardType;

  const ProfileDetail({
    super.key,
    this.keyboardType = TextInputType.text,
    required this.title,
    required this.subtitle,
    this.isOnEditMode = true,
    this.onEditPressed,
    this.onTap,
    required this.editType,
  });

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditProfileDetailDialog(
          initialValue: subtitle,
          title: title,
          keyboardType: keyboardType,
          onSave: (newSubtitle) {
            if (onEditPressed != null) {
              onEditPressed!(newSubtitle);
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
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
                        onPressed: () => _showEditDialog(context),
                        icon: const Icon(
                          Icons.edit,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
