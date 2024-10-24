import 'package:flutter/material.dart';

enum AppColors {
  darkBackground,
  secondaryBackground,
  primaryAccent,
  lightAccent,
}

Color getColor(AppColors color) {
  switch (color) {
    case AppColors.darkBackground:
      return Color(0xFF35374B);
    case AppColors.secondaryBackground:
      return Color(0xFF344955);
    case AppColors.primaryAccent:
      return Color(0xFF50727B);
    case AppColors.lightAccent:
      return Color(0xFF78A083);
    default:
      return Colors.black;
  }
}
