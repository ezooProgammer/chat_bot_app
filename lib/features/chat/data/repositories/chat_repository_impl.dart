// features/chat/data/repositories/chat_repository_impl.dart

import 'package:dartz/dartz.dart';

import '../../../../core/error/chat_exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/services/connectivity_service.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final ConnectivityService connectivityService;

  ChatRepositoryImpl(this.remoteDataSource, this.connectivityService);

  @override
  Future<Either<Failure, ChatMessageEntity>> sendMessage(String prompt) async {
    // 1) فحص الاتصال
    final hasInternet = await connectivityService.hasConnection;
    if (!hasInternet) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    // 2) الإرسال
    try {
      final result = await remoteDataSource.sendMessageToGemini(prompt);
      return Right(result);
    } on ChatException catch (e) {
      return Left(_mapChatException(e));
    } catch (e) {
      return Left(ServerFailure('حدث خطأ غير متوقع. حاول مرة أخرى.'));
    }
  }

  Failure _mapChatException(ChatException e) {
    switch (e.type) {
      case ChatErrorType.network:
        return NetworkFailure(e.message);
      case ChatErrorType.timeout:
        return TimeoutFailure(e.message);
      case ChatErrorType.quotaExceeded:
        return RateLimitFailure(e.message, retryAfter: e.retryAfter);
      case ChatErrorType.unauthorized:
        return AuthFailure(e.message);
      case ChatErrorType.safetyBlocked:
        return SafetyFailure(e.message);
      case ChatErrorType.serverError:
      case ChatErrorType.emptyResponse:
      case ChatErrorType.unknown:
        return ServerFailure(e.message);
    }
  }
}
