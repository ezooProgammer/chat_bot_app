// features/chat/presentation/widgets/chat_empty_state.dart
import 'package:chat_bot_spp/core/theme/app_box_decoration.dart';
import 'package:chat_bot_spp/core/theme/app_colors.dart';
import 'package:chat_bot_spp/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ChatEmptyState extends StatelessWidget {
  final ValueChanged<String> onSuggestionTap;

  const ChatEmptyState({super.key, required this.onSuggestionTap});

  static const Color bgColor = AppColors.chatEmptyStateBackground;

  static const List<_Suggestion> _suggestions = [
    _Suggestion(
      icon: HugeIcon(icon: HugeIcons.strokeRoundedTaskDone01),
      title: 'اسألني أي شيء',
      subtitle: 'معلومات، تفسيرات، أو نصائح',
      prompt: 'أريد أن أسألك عن موضوع ما',
    ),
    _Suggestion(
      icon: HugeIcon(icon: HugeIcons.strokeRoundedIdea),
      title: 'اكتب لي نصًا',
      subtitle: 'مقال، رسالة، أو منشور',
      prompt: 'اكتب لي مقالًا قصيرًا عن...',
    ),
    _Suggestion(
      icon: HugeIcon(icon: HugeIcons.strokeRoundedTranslate),
      title: 'ترجم لي',
      subtitle: 'من وإلى أي لغة',
      prompt: 'ترجم لي النص التالي:',
    ),
    _Suggestion(
      icon: HugeIcon(icon: HugeIcons.strokeRoundedCode),
      title: 'ساعدني في البرمجة',
      subtitle: 'أكواد، أخطاء، أو أفكار',
      prompt: 'أحتاج مساعدة في كتابة كود',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const horizontalPadding = 20.0;
    final availableWidth = screenWidth - (horizontalPadding * 2);
    final isWide = availableWidth > 500;
    final crossAxisCount = isWide ? 4 : 2;
    const spacing = 12.0;
    final itemWidth =
        (availableWidth - spacing * (crossAxisCount - 1)) / crossAxisCount;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        horizontalPadding,
        40,
        horizontalPadding,
        20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'أنا هنا لمساعدتك. اختر اقتراحًا\nأو اكتب سؤالك مباشرة',
            textAlign: TextAlign.center,
            style: AppTextStyle.emptyStateDescription,
          ),

          const SizedBox(height: 32),

          Wrap(
            spacing: spacing,
            runSpacing: spacing,
            alignment: WrapAlignment.center,
            children: _suggestions
                .map(
                  (s) => SizedBox(
                    width: itemWidth,
                    child: _SuggestionCard(
                      suggestion: s,
                      onTap: () => onSuggestionTap(s.prompt),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _Suggestion {
  final Widget icon;
  final String title;
  final String subtitle;
  final String prompt;

  const _Suggestion({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.prompt,
  });
}

class _SuggestionCard extends StatefulWidget {
  final _Suggestion suggestion;
  final VoidCallback onTap;

  const _SuggestionCard({required this.suggestion, required this.onTap});

  @override
  State<_SuggestionCard> createState() => _SuggestionCardState();
}

class _SuggestionCardState extends State<_SuggestionCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: AppBoxDecoration.suggestionCard,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: AppBoxDecoration.suggestionIcon,
                child: Center(child: widget.suggestion.icon),
              ),

              const SizedBox(height: 10),

              Text(
                widget.suggestion.title,
                style: AppTextStyle.suggestionTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 3),

              Text(
                widget.suggestion.subtitle,
                style: AppTextStyle.suggestionSubtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
