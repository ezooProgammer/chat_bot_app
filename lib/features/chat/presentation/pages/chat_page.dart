import 'package:chat_bot_spp/core/extensions/num_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/chat_cubit.dart';
import '../cubit/chat_state.dart';
import '../widgets/app_bar_chat_page.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_empty_state.dart' show ChatEmptyState;
import '../widgets/chat_input_bar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    context.read<ChatCubit>().sendUserMessage(trimmed);
    _controller.clear();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatStateData && state.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage!),
                      backgroundColor: Theme.of(context).colorScheme.error,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is ChatInitial) {
                  return const Center(child: CircularProgressIndicator());
                }

                final chatData = state as ChatStateData;
                _scrollToBottom();

                // ✅ إذا لا توجد رسائل، اعرض الاقتراحات
                final hasNoMessages =
                    chatData.messages.isEmpty && !chatData.isLoading;

                return CustomScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: [
                    // ===== الـ SliverAppBar =====
                    const AppBarChatPage(),

                    // ===== المحتوى =====
                    if (hasNoMessages)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: ChatEmptyState(
                          onSuggestionTap: (prompt) => _sendMessage(prompt),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
                        sliver: SliverList.builder(
                          itemCount:
                              chatData.messages.length +
                              (chatData.isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == chatData.messages.length &&
                                chatData.isLoading) {
                              return const _TypingIndicator();
                            }
                            final msg = chatData.messages[index];
                            return ChatBubble(message: msg);
                          },
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          ChatInputBar(controller: _controller, onSend: _sendMessage),
        ],
      ),
    );
  }
}

// ===== مؤشر "يكتب الآن..." =====
class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [_dot(0), 4.sbw, _dot(150), 4.sbw, _dot(300)],
        ),
      ),
    );
  }

  Widget _dot(int delayMs) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.4, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      builder: (context, value, child) => Opacity(opacity: value, child: child),
      child: Container(
        width: 7,
        height: 7,
        decoration: const BoxDecoration(
          color: Color(0xFF8465EE),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
