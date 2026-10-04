import 'package:chat_bot_spp/core/extensions/num_extension.dart'
    show NumExtension;
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class AppBarChatPage extends StatelessWidget {
  const AppBarChatPage({super.key});

  static const double expandedHeight = 150;
  static const Color _bgColor = Color.fromARGB(255, 241, 243, 242);
  static const Color _textColor = Color(0xFF2F3E46);
  static const Color _subTextColor = Color(0xFF5C6B63);
  static const Color _accentColor = Color(0xFF8465EE);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      snap: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: _bgColor,
      surfaceTintColor: Colors.transparent,
      foregroundColor: _textColor,

      // ===== الارتفاع عند التمدد =====
      expandedHeight:expandedHeight,

      // ===== الارتفاع عند الطي =====
      toolbarHeight: kToolbarHeight,

      centerTitle: true,

      // ===== المحتوى المرن =====
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final top = constraints.biggest.height;
        
          // نسبة الطي: 0 عند التمدد الكامل، 1 عند الطي الكامل
          final t =((expandedHeight + MediaQuery.of(context).padding.top - top) / (expandedHeight - kToolbarHeight))
                  .clamp(0.0, 1.0);

          return FlexibleSpaceBar(
            centerTitle: true,
            titlePadding: EdgeInsetsDirectional.only(
              start: 52,
              end: 52,
              bottom: 12 + (1 - t) * 0, // يبقى ثابتًا
            ),
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              // يظهر العنوان المصغّر فقط بعد الطي
              opacity: t > 0.7 ? 1 : 0,
              child: const Text(
                'Gemini Assistant',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _textColor,
                ),
              ),
            ),

            // ===== الخلفية مع الأيقونة والنصوص =====
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFD8E2DC), Color(0xFFE4ECE7)],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      

                      // ===== الأيقونة =====
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: _accentColor,
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: HugeIcon(
                            icon: HugeIcons.strokeRoundedChatGpt,
                            size: 28,
                            color: _accentColor,
                          ),
                        ),
                      ),
                   

                      // ===== العنوان =====
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          const Text(
                            'Gemini Assistant',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: _textColor,
                              letterSpacing: 0.2,
                            ),
                          ),
                          5.sbw,
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF4CAF50),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      // ===== الوصف =====
                      const Text(
                        'كيف يمكنني مساعدتك اليوم؟',
                        style: TextStyle(fontSize: 11.5, color: _subTextColor),
                      ),

                      6.sbh,
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
