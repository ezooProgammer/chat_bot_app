import 'package:dartz/dartz.dart'; // يُفضل استخدام dartz لإدارة الأخطاء بحزمة Either
import '../../../../core/error/failures.dart';
import '../entities/chat_message_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, ChatMessageEntity>> sendMessage(String prompt);
}
