import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class HealthButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  const HealthButtonWidget(
      {Key? key,
      required this.text,
      required this.onTap,
      this.color = AppColors.lighter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Center(
        child: InkWell(
          onTap: onTap,
          child: Text(text),
        ),
      ),
    );
  }
}
