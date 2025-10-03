// lib/services/recommendation_service.dart
import '../model/medication.dart';
import '../repository/bookmark_repository.dart';
import '../repository/medication_repository.dart';
import '../repository/tracking_repository.dart';

class RecommendationService {
  final TrackingRepository trackingRepository;
  final MedicationRepository medicationRepository;
  final BookmarkRepository bookmarkRepository;

  RecommendationService({
    required this.trackingRepository,
    required this.medicationRepository,
    required this.bookmarkRepository,
  });

  // Combined health recommendations from both implementations
  List<String> getHealthRecommendations() {
    final recommendations = <String>[];
    final searchHistory = trackingRepository.getSearchHistory();
    final symptomRecords = trackingRepository.getSymptomRecords();
    final bookmarks = bookmarkRepository.getBookmarks();

    // 1. Identify most common symptoms
    final symptomFrequency = <String, int>{};
    for (final record in symptomRecords) {
      if (record != null) {
        symptomFrequency[record.symptom] =
            (symptomFrequency[record.symptom] ?? 0) + 1;
      }
    }

    // 2. Identify most searched conditions
    final searchFrequency = <String, int>{};
    for (final item in searchHistory) {
      if (item != null) {
        searchFrequency[item.query] =
            (searchFrequency[item.query] ?? 0) + 1;
      }
    }

    // 3. Generate recommendations based on symptoms
    if (symptomFrequency.containsKey('Headache') &&
        symptomFrequency.containsKey('Fever')) {
      recommendations.add('Your frequent headaches and fever might indicate flu. '
          'Consider resting and staying hydrated.');
    }

    // 4. Generate recommendations based on search history
    final mostSearched = searchFrequency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    if (mostSearched.take(3).any((e) => e.key.contains('Allergies'))) {
      recommendations.add('Based on your allergy research, you might want to check '
          'pollen forecasts in your area.');
    }

    // 5. Generate recommendations based on bookmarks
    if (bookmarks.any((b) => b?.title.contains('Diabetes') ?? false)) {
      recommendations.add('Since you\'ve bookmarked diabetes information, '
          'remember to monitor your blood sugar regularly.');
    }

    // 6. Add general health tips
    recommendations.add('Regular exercise can help improve your overall health. '
        'Try to get at least 30 minutes of activity daily.');

    return recommendations;
  }

  // Medication recommendations from first implementation
  List<Medication> getMedicationRecommendations() {
    final symptoms = trackingRepository.getSymptomRecords()
        .where((record) => record != null)
        .map((record) => record!.symptom)
        .toSet()
        .toList();

    final recommendedMeds = <Medication>{};

    for (final symptom in symptoms) {
      final meds = medicationRepository.getMedicationsForCondition(symptom);
      recommendedMeds.addAll(meds);
    }

    return recommendedMeds.toList();
  }

  // Personalized recommendations from second implementation
  List<String> getPersonalizedRecommendations() {
    final recommendations = <String>[];
    final symptoms = trackingRepository.getSymptomRecords();
    final bookmarks = bookmarkRepository.getBookmarks();
    final searchHistory = trackingRepository.getSearchHistory();

    // 1. Based on symptoms
    if (symptoms.any((s) => s?.symptom.toLowerCase().contains('headache') ?? false)) {
      recommendations.add('You\'ve reported headaches. Consider tracking your '
          'hydration levels as dehydration is a common cause.');
    }

    // 2. Based on bookmarks
    if (bookmarks.any((b) => b?.title.contains('Diabetes') ?? false)) {
      recommendations.add('Since you\'ve bookmarked diabetes information, '
          'remember to monitor your blood sugar regularly.');
    }

    // 3. Based on search history
    if (searchHistory.any((s) => s?.query.toLowerCase().contains('allergy') ?? false)) {
      recommendations.add('Allergy season is approaching. Consider checking '
          'pollen forecasts in your area.');
    }

    // 4. General health tips
    recommendations.add('Regular physical activity can improve your overall '
        'health. Aim for at least 150 minutes per week.');

    return recommendations;
  }
}