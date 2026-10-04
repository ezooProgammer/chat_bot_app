// features/chat/data/datasources/chat_exception.dart

class ChatException implements Exception {
  final ChatErrorType type;
  final String message;
  final int? statusCode;
  final Duration? retryAfter;

  ChatException(this.type, this.message, {this.statusCode, this.retryAfter});

  @override
  String toString() => message;
}

enum ChatErrorType {
  quotaExceeded, // تجاوز الحد
  unauthorized, // مفتاح خاطئ
  network, // لا يوجد إنترنت
  timeout, // انتهت المهلة
  serverError, // خطأ في الخادم
  emptyResponse, // رد فارغ
  safetyBlocked, // حجب بسبب سياسة المحتوى
  unknown, // غير معروف
}
