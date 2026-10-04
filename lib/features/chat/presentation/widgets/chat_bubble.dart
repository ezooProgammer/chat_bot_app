import 'package:chat_bot_spp/features/chat/presentation/widgets/icon_ai.dart';
import 'package:flutter/material.dart';
import '../../../../core/extensions/num_extension.dart';
import '../../domain/entities/chat_message_entity.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessageEntity message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // فقاعة الرسالة
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isUser ? const Color(0xFF8465EE) : const Color(0xFFE0E0E0),
                  width: 1,
                ),
                color: isUser
                    ? const Color(0xFF8465EE)
                    : const Color(0xFFFCFCFC),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isUser ? 20 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 20),
                ),
                
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: isUser ? Colors.white : const Color(0xFF2F3E46),
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ),
          ),

          if (!isUser) ...[10.sbw, IconAi()],
        ],
      ),
    );
  }
}
