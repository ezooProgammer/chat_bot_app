// core/di/injection_container.dart

import 'package:get_it/get_it.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../features/chat/data/datasources/chat_remote_data_source.dart';
import '../../features/chat/data/repositories/chat_repository_impl.dart';
import '../../features/chat/domain/repositories/chat_repository.dart';
import '../../features/chat/domain/usecases/send_message_usecase.dart';
import '../../features/chat/presentation/cubit/chat_cubit.dart';
import '../services/connectivity_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ===========================================================================
  // 1. Feature: Chat
  // ===========================================================================
  sl.registerFactory(() => ChatCubit(sl()));

  sl.registerLazySingleton(() => SendMessageUseCase(sl()));

  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      sl<ChatRemoteDataSource>(),
      sl<ConnectivityService>(),
    ),
  );

  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(sl()),
  );

  // ===========================================================================
  // 2. External
  // ===========================================================================

  // ✅ اقرأ المفتاح من --dart-define
  const apiKey = String.fromEnvironment('GEMINI_API_KEY');
  if (apiKey.isEmpty) {
    throw Exception(
      'GEMINI_API_KEY غير معرّف. شغّل مع --dart-define=GEMINI_API_KEY=xxx',
    );
  }

  sl.registerLazySingleton<GenerativeModel>(
    () => GenerativeModel(
      model: 'gemini-3.8-flash', // ✅ الموديل الأحدث والمستقر

      apiKey: apiKey,
    ),
  );

  sl.registerLazySingleton<ConnectivityService>(() => ConnectivityService());
}
