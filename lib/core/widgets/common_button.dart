import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class CommonButton extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final Color textColor;
  final Color contentColor;
  final EdgeInsets? padding;
  final bool isLoading;
  final Function()? onTap;
  final bool isDisabled;
  final BorderRadius? borderRadius;
  final double? fontSize;

  const CommonButton({
    super.key,
    required this.backgroundColor,
    this.borderColor = AppColors.primaryColor,
    required this.text,
    required this.textColor,
    this.padding,
    this.isLoading = false,
    this.onTap,
    required this.contentColor,
    this.isDisabled = false,
    this.borderRadius,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Opacity(
        opacity: isDisabled ? 0.5 : 1,
        child: Container(
          padding: padding ??
              const EdgeInsets.symmetric(
                vertical: 7,
              ),
          width: double.infinity,
          // height: 50.0,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            border: Border.all(
              color: AppColors.primaryBorderColor,
              width: 2.0,
            ),
            borderRadius: borderRadius,
          ),
          child: isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _Loading(contentColor: contentColor),
                  ],
                )
              : Center(
                  child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize ?? 20,
                    fontFamily: 'EB Garamond',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 4,
                  ),
                )),
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  final Color contentColor;

  const _Loading({
    required this.contentColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20.0,
      height: 20.0,
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(contentColor),
      ),
    );
  }
}
