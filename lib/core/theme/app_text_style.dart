import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyle {
  AppTextStyle._();

  static const TextStyle emptyStateDescription = TextStyle(
    fontSize: 13.5,
    color: AppColors.secondaryText,
    height: 1.6,
  );

  static const TextStyle suggestionTitle = TextStyle(
    fontSize: 9,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  );

  static const TextStyle suggestionSubtitle = TextStyle(
    fontSize: 11,
    color: AppColors.secondaryText,
    height: 1.3,
  );
}
