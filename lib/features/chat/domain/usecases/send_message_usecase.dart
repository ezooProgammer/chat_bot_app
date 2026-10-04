import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/chat_message_entity.dart';
import '../repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;
  SendMessageUseCase(this.repository);
  Future<Either<Failure, ChatMessageEntity>> call(String prompt) {
    return repository.sendMessage(prompt);
  }
}
