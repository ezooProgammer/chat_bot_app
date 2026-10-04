import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/chat_message_entity.dart';
import '../../domain/usecases/send_message_usecase.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SendMessageUseCase sendMessageUseCase;
  final List<ChatMessageEntity> _messages = [];

  ChatCubit(this.sendMessageUseCase) : super(ChatInitial()) {
    emit(ChatStateData(messages: List.from(_messages)));
  }

  Future<void> sendUserMessage(String prompt) async {
    if (prompt.trim().isEmpty) return;

    _messages.add(ChatMessageEntity(text: prompt, isUser: true));
    emit(ChatStateData(messages: List.from(_messages), isLoading: true));

    final result = await sendMessageUseCase(prompt);
 // qq
    result.fold(
      (failure) {
        // ✅ افحص نوع الفشل
        // ✅ سجل الخطأ في وحدة التحكم
        emit(
          ChatStateData(
            messages: List.from(_messages),
            isLoading: false,
            errorMessage: failure.message,
          ),
        );
      },
      (botMessage) {
        _messages.add(botMessage);
        emit(ChatStateData(messages: List.from(_messages), isLoading: false));
      },
    );
  }
}
