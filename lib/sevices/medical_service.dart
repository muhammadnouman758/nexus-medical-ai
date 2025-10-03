// lib/services/medical_service.dart
import 'package:google_generative_ai/google_generative_ai.dart';

import '../model/disease_info.dart';

class MedicalService {
  final GenerativeModel _model;
  static const _defaultDisclaimer =
      'This information is not medical advice. Consult a healthcare professional.';

  MedicalService({required String apiKey})
      : _model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  Future<DiseaseInfo> getDiseaseInfo(String query) async {
    try {
      final prompt = '''
      As a board-certified medical professional, provide comprehensive yet concise information about "$query" using this exact structure:

      **Overview**: [2-3 sentence description]
      **Symptoms**: 
      - [Symptom 1]
      - [Symptom 2]
      **Causes**: 
      - [Cause 1]
      - [Cause 2]
      **Treatment**: 
      - [Treatment 1]
      - [Treatment 2]
      **Drug Recommendations**: 
      - [Drug 1] [image:URL]
      - [Drug 2]
      **Disclaimer**: $_defaultDisclaimer
      ''';

      final response = await _model.generateContent([Content.text(prompt)]);
      return _parseResponse(query, response.text ?? '');
    } catch (e) {
      return DiseaseInfo(
        name: query,
        overview: 'Failed to load information',
        symptoms: [],
        causes: [],
        treatments: [],
        medications: [],
        disclaimer: _defaultDisclaimer,
      );
    }
  }

  DiseaseInfo _parseResponse(String diseaseName, String response) {
    // Extract image URLs first
    final imageUrls = RegExp(r'\[image:(https?://[^\s]+)\]')
        .allMatches(response)
        .map((m) => m.group(1)!)
        .toList();

    // Remove image tags from response
    response = response.replaceAll(RegExp(r'\[image:(https?://[^\s]+)\]'), '');

    // Parse each section
    String _extractSection(String sectionName) {
      final pattern = RegExp(
        '$sectionName:\\s*([\\s\\S]*?)(?=\\n\\*\\*[A-Z][a-z]+:|\\nDisclaimer:|\\n\$)',
        caseSensitive: false,
      );
      return pattern.firstMatch(response)?.group(1)?.trim() ?? '';
    }

    List<String> _parseBulletPoints(String content) {
      return content
          .split('\n')
          .where((line) => line.trim().startsWith('-'))
          .map((line) => line.replaceFirst('-', '').trim())
          .where((line) => line.isNotEmpty)
          .toList();
    }

    List<Medication> _parseMedications(String content) {
      final medLines = _parseBulletPoints(content);
      return medLines.map((line) {
        final name = line.split('[').first.trim();
        return Medication(
          name: name,
          dosage: _getDefaultDosage(name),
          precautions: _getDefaultPrecautions(name),
          imageUrl: '', // Will be filled from imageUrls list
          indications: [diseaseName],
        );
      }).toList();
    }

    return DiseaseInfo(
      name: diseaseName,
      overview: _extractSection('Overview'),
      symptoms: _parseBulletPoints(_extractSection('Symptoms')),
      causes: _parseBulletPoints(_extractSection('Causes')),
      treatments: _parseBulletPoints(_extractSection('Treatment')),
      medications: _parseMedications(_extractSection('Drug Recommendations')),
      disclaimer: _extractSection('Disclaimer').isNotEmpty
          ? _extractSection('Disclaimer')
          : _defaultDisclaimer,
      imageUrls: imageUrls.isNotEmpty ? imageUrls : null,
    );
  }

  String _getDefaultDosage(String medication) {
    // In a real app, this would come from a database
    const defaultDosages = {
      'Ibuprofen': '200-400mg every 4-6 hours',
      'Amoxicillin': '500mg every 8 hours',
    };
    return defaultDosages[medication] ?? 'Consult doctor for dosage';
  }

  String _getDefaultPrecautions(String medication) {
    // In a real app, this would come from a database
    const defaultPrecautions = {
      'Ibuprofen': 'Take with food. Avoid alcohol.',
      'Amoxicillin': 'Complete full course. May cause diarrhea.',
    };
    return defaultPrecautions[medication] ?? 'Use as directed by healthcare provider';
  }
}