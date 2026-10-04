import 'package:flutter/material.dart';

class IconAi extends StatelessWidget {
  const IconAi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: const BoxDecoration(
        color: Color(0xFFFCFCFC),
        shape: BoxShape.circle,
        border: Border.fromBorderSide(
          BorderSide(color: Colors.black, width: 0.2),
        ),
      ),
      child: Center(child: Image.asset('assets/images/AI-chat-gpt-logo.webp')),
    );
  }
}
