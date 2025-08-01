// lib/services/recommendation_service.dart
import '../model/medication.dart';
import '../repository/medication_repository.dart';
import '../repository/tracking_repository.dart';

class RecommendationService {
  final TrackingRepository trackingRepository;
  final MedicationRepository medicationRepository;

  RecommendationService({
    required this.trackingRepository,
    required this.medicationRepository,
  });

  List<String> getHealthRecommendations() {
    final searchHistory = trackingRepository.getSearchHistory();
    final symptomRecords = trackingRepository.getSymptomRecords();

    // 1. Identify most common symptoms
    final symptomFrequency = <String, int>{};
    for (final record in symptomRecords) {
      symptomFrequency[record.symptom] =
          (symptomFrequency[record.symptom] ?? 0) + 1;
    }

    // 2. Identify most searched conditions
    final searchFrequency = <String, int>{};
    for (final item in searchHistory) {
      searchFrequency[item.query] =
          (searchFrequency[item.query] ?? 0) + 1;
    }

    // 3. Generate recommendations
    final recommendations = <String>[];

    // Based on symptoms
    if (symptomFrequency.containsKey('Headache') &&
        symptomFrequency.containsKey('Fever')) {
      recommendations.add('Your frequent headaches and fever might indicate flu. '
          'Consider resting and staying hydrated.');
    }

    // Based on search history
    final mostSearched = searchFrequency.entries
        .toList()
        .sort((a, b) => b.value.compareTo(a.value))
        .take(3)
        .map((e) => e.key)
        .toList();

    if (mostSearched.contains('Allergies')) {
      recommendations.add('Based on your allergy research, you might want to check '
          'pollen forecasts in your area.');
    }

    // General health tips
    recommendations.add('Regular exercise can help improve your overall health. '
        'Try to get at least 30 minutes of activity daily.');

    return recommendations;
  }

  List<Medication> getMedicationRecommendations() {
    final symptoms = trackingRepository.getSymptomRecords()
        .map((e) => e?.symptom)
        .toSet()
        .toList();

    final recommendedMeds = <Medication>{};

    for (final symptom in symptoms) {
      final meds = medicationRepository.getMedicationsForCondition(symptom);
      recommendedMeds.addAll(meds);
    }

    return recommendedMeds.toList();
  }
}