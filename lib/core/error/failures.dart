// core/error/failures.dart

abstract class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'لا يوجد اتصال بالإنترنت']);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = 'انتهت مهلة الطلب، حاول مرة أخرى']);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'خطأ في الخادم']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'غير مصرح بالوصول']);
}

class SafetyFailure extends Failure {
  const SafetyFailure([super.message = 'تم حجب الرد']);
}

class RateLimitFailure extends Failure {
  final Duration? retryAfter;
  const RateLimitFailure(super.message, {this.retryAfter});
}
