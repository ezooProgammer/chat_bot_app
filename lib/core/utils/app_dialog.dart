import 'package:flutter/material.dart';

abstract class AppDialog {
  static Future<bool?> showConfirmation({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'تأكيد',
    String cancelText = 'إلغاء',
    Color? confirmColor,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  confirmColor ?? Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }
}

/*

final bool? isConfirmed = await AppDialog.showConfirmation(
  context: context,
  title: 'حذف العنصر',
  message: 'هل أنت تأكد من نقل هذا العنصر إلى سلة المهملات؟',
  confirmText: 'حذف',
  confirmColor: Colors.red,
);

if (isConfirmed == true) {
  // نفذ عملية الحذف
}


*/
