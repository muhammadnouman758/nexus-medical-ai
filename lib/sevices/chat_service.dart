// lib/services/chat_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/chat.dart';

class ChatService {
  static const String _apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";
  final String _apiKey ;

  ChatService({required String apiKey}) : _apiKey = "AIzaSyDc9cpoXFI9zcHvLkO0j_6t8mIdgzNGpTg";

  Future<ChatMessage> getAssistantResponse(
      String userMessage,
      List<ChatMessage> history,
      ) async {
    try {
      // Prepare the request payload
      final payload = {
        "contents": [
          {
            "role": "user",
            "parts": [{"text": userMessage}]
          }
        ],
        "generationConfig": {
          "maxOutputTokens": 1000,
          "temperature": 0.5,
        }
      };

      // Make the API request
      final response = await http.post(
        Uri.parse("$_apiUrl?key=$_apiKey"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      // Handle the response
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final text = data['candidates'][0]['content']['parts'][0]['text'] as String?;

        if (text != null) {
          return ChatMessage(
            content: text.trim(),
            isUser: false,
          );
        } else {
          return ChatMessage(
            content: "Sorry, I couldn't process your request. Please try again.",
            isUser: false,
          );
        }
      } else {
        final error = json.decode(response.body);
        return ChatMessage(
          content: "API Error: ${error['error']['message'] ?? 'Unknown error'}",
          isUser: false,
          status: MessageStatus.error,
        );
      }
    } catch (e) {
      return ChatMessage(
        content: "Network Error: ${e.toString()}",
        isUser: false,
        status: MessageStatus.error,
      );
    }
  }
}