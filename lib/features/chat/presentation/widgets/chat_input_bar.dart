import 'package:chat_bot_spp/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ChatInputBar extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSend;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasText = widget.controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _handleSend() {
    final text = widget.controller.text.trim();
    if (text.isEmpty) return;
    widget.onSend(text);
    widget.controller.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.11,
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(45)),

          border: Border(top: BorderSide(color: Colors.grey, width: 0.3)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // ===== حقل الكتابة =====
            Expanded(
              child: Container(
                constraints: const BoxConstraints(
                  minHeight: 48,
                  maxHeight: 130,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F7F5),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFD8E2DC), width: 1),
                ),
                child: AppTextField(
                  controller: widget.controller,
                  keyboardType: TextInputType.multiline,
                  hintText: 'اكتب رسالتك هنا...',
                  hintStyle: const TextStyle(
                    color: Color(0xFF9AA8A0),
                    fontSize: 14,
                  ),
                  suffixIconConstraints: const BoxConstraints(
                    minWidth: 45,
                    maxWidth: 45,
                    minHeight: 45,
                    maxHeight: 45,
                  ),
                  suffixWidget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedMessageQuestion,
                      color: const Color(0xFF9AA8A0),
                      size: 20,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color(0xFF8465EE),
                      width: 0.2,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  fillColor: const Color(0xFFFCFCFC),

                  maxLines: 1,
                ),
              ),
            ),

            const SizedBox(width: 8),

            // ===== زر الإرسال =====
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF8465EE),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8465EE),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: _hasText ? _handleSend : null,
                  child: Center(
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedSent,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
