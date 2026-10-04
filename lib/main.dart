import 'package:chat_bot_spp/core/di/injection_container.dart' as di;
import 'package:chat_bot_spp/run_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await di.init();
  runApp(const RunApp());
}
