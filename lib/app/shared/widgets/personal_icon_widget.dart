import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class PersonalIconWidget extends StatelessWidget {
  final String text;
  final Color borderColor;
  const PersonalIconWidget({
    Key? key,
    required this.text,
    this.borderColor = AppColors.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Center(
        child: Text(text),
      ),
    );
  }
}
