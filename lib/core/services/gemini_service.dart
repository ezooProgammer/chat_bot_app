import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final String _apiKey;
  late final GenerativeModel _model;

  GeminiService({required String apiKey, String modelName = 'gemini-2.5-flash'})
    : _apiKey = apiKey {
    _model = GenerativeModel(model: modelName, apiKey: _apiKey);
  }

  /// إرسال نص واستلام الرد
  Future<String?> sendTextMessage(String prompt) async {
    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text;
    } catch (e) {
      throw Exception('خطأ أثناء الاتصال بالخدمة: $e');
    }
  }
}
