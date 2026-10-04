import 'package:flutter/material.dart';

extension NumExtension on num {
  // مسافة رأسية
  Widget get sbh => SizedBox(height: toDouble());

  // مسافة أفقيّة
  Widget get sbw => SizedBox(width: toDouble());
}

// طريقة الاستخدام داخل الـ UI:
// Column(
//   children: [
//     Text('Title'),
//     16.sbh, // مسافة رأسية 16
//     Text('Subtitle'),
//   ],
// )