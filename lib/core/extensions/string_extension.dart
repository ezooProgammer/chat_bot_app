extension StringExtension on String {
  // التحقق من صحة الإيميل
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  // التحقق من قوة كلمة المرور (6 أحرف على الأقل)
  bool get isValidPassword => length >= 6;

  // التحقق من أن النص يحتوي أرقام فقط
  bool get isNumeric => double.tryParse(this) != null;

  // جعل أول حرف كبير (Capitalize)
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}