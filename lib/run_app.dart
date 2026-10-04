import 'package:chat_bot_spp/core/di/injection_container.dart' as di;
import 'package:chat_bot_spp/core/theme/theme_app.dart';
import 'package:chat_bot_spp/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_bot_spp/features/chat/presentation/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class RunApp extends StatelessWidget {
  const RunApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar'), // العربية
        Locale('en'), // الإنجليزية
      ],
      theme: ThemeApp.themeApp(),
      // ===== المندوبين (Delegates) =====
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      home: BlocProvider(
        create: (context) => di.sl<ChatCubit>(),
        child: const ChatPage(),
      ),
    );
  }
}
