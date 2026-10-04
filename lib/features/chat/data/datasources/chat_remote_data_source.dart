// features/chat/data/datasources/chat_remote_data_source.dart

import 'dart:async';
import 'dart:io';

import 'package:chat_bot_spp/core/error/chat_exception.dart'
    show ChatException, ChatErrorType;
import 'package:chat_bot_spp/features/chat/data/models/chat_message_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

// ✅ أضفنا الواجهة المجردة هنا
abstract class ChatRemoteDataSource {
  Future<ChatMessageModel> sendMessageToGemini(String prompt);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final GenerativeModel _model;
  ChatSession? _chatSession;

  ChatRemoteDataSourceImpl(this._model);

  ChatSession get chatSession => _chatSession ??= _model.startChat();

  @override
  Future<ChatMessageModel> sendMessageToGemini(String prompt) async {
    try {
      final response = await chatSession.sendMessage(Content.text(prompt));

      // فحص الحجب الأمني
      if (response.candidates.isEmpty) {
        throw ChatException(
          ChatErrorType.safetyBlocked,
          'تم حجب الرد لأسباب أمنية. جرّب صياغة سؤالك بطريقة أخرى.',
        );
      }

      final text = response.text;
      if (text == null || text.trim().isEmpty) {
        throw ChatException(
          ChatErrorType.emptyResponse,
          'لم يصل رد من الذكاء الاصطناعي. حاول مرة أخرى.',
        );
      }

      return ChatMessageModel.fromGeminiResponse(text);
    } on GenerativeAIException catch (e) {
      throw _mapGenerativeAIException(e);
    } on SocketException {
      throw ChatException(
        ChatErrorType.network,
        'لا يوجد اتصال بالإنترنت. تحقق من الشبكة وحاول مجددًا.',
      );
    } on TimeoutException {
      throw ChatException(
        ChatErrorType.timeout,
        'استغرق الطلب وقتًا طويلاً. حاول مرة أخرى.',
      );
    } on ChatException {
      rethrow;
    } catch (e) {
      throw ChatException(
        ChatErrorType.unknown,
        'حدث خطأ غير متوقع. حاول مرة أخرى.',
      );
    }
  }

  ChatException _mapGenerativeAIException(GenerativeAIException e) {
    final message = e.message.toLowerCase();
    final code = _extractStatusCode(e.message);

    // 1) تجاوز الحد
    if (code == 429 ||
        message.contains('quota') ||
        message.contains('rate limit')) {
      final retryAfter = _extractRetryDuration(e.message);
      return ChatException(
        ChatErrorType.quotaExceeded,
        retryAfter != null
            ? 'لقد استهلكت حصتك اليومية. يرجى المحاولة بعد ${_formatDuration(retryAfter)}.'
            : 'لقد استهلكت حصتك من الطلبات. يرجى المحاولة لاحقًا.',
        statusCode: 429,
        retryAfter: retryAfter,
      );
    }

    // 2) مفتاح خاطئ / غير مصرح
    if (code == 401 ||
        code == 403 ||
        message.contains('api key') ||
        message.contains('permission')) {
      return ChatException(
        ChatErrorType.unauthorized,
        'هناك مشكلة في صلاحية الوصول. يرجى التواصل مع الدعم.',
        statusCode: code,
      );
    }

    // 3) خطأ في الخادم
    if (code != null && code >= 500) {
      return ChatException(
        ChatErrorType.serverError,
        'الخادم مشغول حاليًا. حاول بعد قليل.',
        statusCode: code,
      );
    }

    // 4) محتوى محجوب
    if (message.contains('safety') || message.contains('blocked')) {
      return ChatException(
        ChatErrorType.safetyBlocked,
        'تم حجب الرد لأسباب تتعلق بسياسة المحتوى. جرّب صياغة أخرى.',
      );
    }
    return ChatException(
      ChatErrorType.unknown,
      'حدث خطأ أثناء الاتصال بالذكاء الاصطناعي. حاول مرة أخرى.',
      statusCode: code,
    );
  }

  int? _extractStatusCode(String msg) {
    final match = RegExp(r'\[(\d{3})\s').firstMatch(msg);
    if (match != null) return int.tryParse(match.group(1)!);
    final match2 = RegExp(r'status(code)?[:\s]+(\d{3})').firstMatch(msg);
    if (match2 != null) return int.tryParse(match2.group(2)!);
    return null;
  }

  Duration? _extractRetryDuration(String msg) {
    final match = RegExp(r'retry in ([\dhm\.]+s)').firstMatch(msg);
    if (match == null) return null;
    final raw = match.group(1)!;
    int hours = 0, minutes = 0;
    double seconds = 0;

    final hMatch = RegExp(r'(\d+)h').firstMatch(raw);
    if (hMatch != null) hours = int.parse(hMatch.group(1)!);

    final mMatch = RegExp(r'(\d+)m').firstMatch(raw);
    if (mMatch != null) minutes = int.parse(mMatch.group(1)!);

    final sMatch = RegExp(r'([\d\.]+)s').firstMatch(raw);
    if (sMatch != null) seconds = double.parse(sMatch.group(1)!);

    return Duration(hours: hours, minutes: minutes, seconds: seconds.round());
  }

  String _formatDuration(Duration d) {
    if (d.inHours > 0) {
      return '${d.inHours} ساعة و${d.inMinutes.remainder(60)} دقيقة';
    }
    if (d.inMinutes > 0) {
      return '${d.inMinutes} دقيقة';
    }
    return '${d.inSeconds} ثانية';
  }
}
