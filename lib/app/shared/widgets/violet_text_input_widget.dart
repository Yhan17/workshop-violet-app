import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class VioletTextInputWidget extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const VioletTextInputWidget({
    Key? key,
    required this.text,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: text,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        constraints: const BoxConstraints(
          maxHeight: 40,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(
            color: AppColors.primary,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(
            color: AppColors.primary,
          ),
        ),
        floatingLabelStyle: const TextStyle(
          color: AppColors.primary,
        ),
        labelStyle: const TextStyle(
          color: AppColors.primary,
          fontSize: 14,
        ),
        focusColor: AppColors.primary,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
