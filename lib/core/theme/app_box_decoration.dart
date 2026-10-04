import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppBoxDecoration {
  AppBoxDecoration._();

  static BoxDecoration get suggestionCard => BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(18),
    border: Border.all(color: AppColors.chatEmptyStateBackground, width: 1),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadow.withValues(alpha: 0.04),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static const BoxDecoration suggestionIcon = BoxDecoration(
    border: Border.fromBorderSide(
      BorderSide(color: AppColors.chatEmptyStateBackground, width: 1),
    ),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );
}
