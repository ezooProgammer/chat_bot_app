import '../../domain/entities/chat_message_entity.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatStateData extends ChatState {
  final List<ChatMessageEntity> messages;
  final bool isLoading;
  final String? errorMessage;

  ChatStateData({
    required this.messages,
    this.isLoading = false,
    this.errorMessage,
  });
}
