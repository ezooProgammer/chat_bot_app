import '../../domain/entities/chat_message_entity.dart';

class ChatMessageModel extends ChatMessageEntity {
  const ChatMessageModel({required super.text, required super.isUser});

  factory ChatMessageModel.fromGeminiResponse(String text) {
    return ChatMessageModel(text: text, isUser: false);
  }
}
