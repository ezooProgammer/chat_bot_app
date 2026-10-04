extension DateTimeExtension on DateTime {
  // تنسيق تاريخ YYYY-MM-DD
  String get toDateString =>
      '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

  // حساب الوقت المنقضي
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      return 'منذ ${(difference.inDays / 365).floor()} سنة';
    }
    if (difference.inDays > 30) {
      return 'منذ ${(difference.inDays / 30).floor()} شهر';
    }
    if (difference.inDays > 0) return 'منذ ${difference.inDays} يوم';
    if (difference.inHours > 0) return 'منذ ${difference.inHours} ساعة';
    if (difference.inMinutes > 0) return 'منذ ${difference.inMinutes} دقيقة';
    return 'الآن';
  }
}
