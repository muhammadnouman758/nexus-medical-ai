// lib/services/recommendation_service.dart
import '../repository/bookmark_repository.dart';
import '../repository/tracking_repository.dart';

class RecommendationService {
  final TrackingRepository trackingRepo;
  final BookmarkRepository bookmarkRepo;

  RecommendationService({
    required this.trackingRepo,
    required this.bookmarkRepo,
  });

  List<String> getPersonalizedRecommendations() {
    final recommendations = <String>[];

    // 1. Based on symptoms
    final symptoms = trackingRepo.getSymptomRecords();
    if (symptoms.any((s) => s?.symptom.toLowerCase().contains('headache'))) {
      recommendations.add('You\'ve reported headaches. Consider tracking your '
          'hydration levels as dehydration is a common cause.');
    }

    // 2. Based on bookmarks
    final bookmarks = bookmarkRepo.getBookmarks();
    if (bookmarks.any((b) => b!.title.contains('Diabetes'))) {
      recommendations.add('Since you\'ve bookmarked diabetes information, '
          'remember to monitor your blood sugar regularly.');
    }

    // 3. Based on search history
    final searchHistory = trackingRepo.getSearchHistory();
    if (searchHistory.any((s) => s?.query.contains('allergy'))) {
      recommendations.add('Allergy season is approaching. Consider checking '
          'pollen forecasts in your area.');
    }

    // 4. General health tips
    recommendations.add('Regular physical activity can improve your overall '
        'health. Aim for at least 150 minutes per week.');

    return recommendations;
  }
}