// lib/services/medical_service.dart
import 'package:google_generative_ai/google_generative_ai.dart';

class MedicalService {
  final GenerativeModel _model;

  MedicalService({required String apiKey})
      : _model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  Future<DiseaseInfo> getDiseaseInfo(String query) async {
    final prompt = '''
    As a medical expert, provide information about "$query" in this structure:
    
    **Overview**: [2-3 sentence overview]
    **Symptoms**: [Bulleted list]
    **Causes**: [Bulleted list]
    **Treatment**: [Bulleted list]
    **Drug Recommendations**: [Bulleted list]
    **Disclaimer**: [Standard medical disclaimer]
    ''';

    final response = await _model.generateContent([Content.text(prompt)]);
    return _parseResponse(response.text ?? '');
  }

  DiseaseInfo _parseResponse(String response) {
    // Parsing logic for structured response
  }
}