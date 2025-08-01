// lib/services/chat_service.dart
import 'package:google_generative_ai/google_generative_ai.dart';

import '../model/chat.dart';

class ChatService {
  final GenerativeModel _model;

  ChatService({required String apiKey})
      : _model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  Future<ChatMessage> getAssistantResponse(
      String userMessage,
      List<ChatMessage> history,
      ) async {
    try {
      final prompt = '''
      You are MediHunt+, an AI medical assistant. Your role is to:
      - Provide accurate medical information
      - Help users understand their symptoms
      - Suggest possible conditions based on symptoms
      - Recommend when to seek professional help
      - Offer general health advice
      
      Always include a disclaimer that you are not a substitute for professional medical advice.
      
      Current conversation context:
      ${history.map((msg) => '${msg.isUser ? "User" : "Assistant"}: ${msg.content}').join('\n')}
      
      User message: $userMessage
      ''';

      final response = await _model.generateContent([Content.text(prompt)]);
      return ChatMessage(
        content: response.text ?? 'Sorry, I couldn\'t process your request',
        isUser: false,
      );
    } catch (e) {
      return ChatMessage(
        content: 'Error: ${e.toString()}',
        isUser: false,
        status: MessageStatus.error,
      );
    }
  }
}