// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:medical/screen/symptom_tracker_screen.dart';
import 'package:provider/provider.dart';

import '../model/tracking.dart';
import '../repository/tracking_repository.dart';
import '../sevices/recommendation_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TrackingRepository trackingRepo;
  late final RecommendationService recommendationService;
  List<SearchHistoryItem> searchHistory = [];
  List<String> recommendations = [];

  @override
  void initState() {
    super.initState();
    trackingRepo = context.read<TrackingRepository>();
    recommendationService = context.read<RecommendationService>();
    _loadData();
  }

  Future<void> _loadData() async {
    searchHistory = trackingRepo.getSearchHistory();
    recommendations = recommendationService.getHealthRecommendations();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MediHunt+')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Search bar (existing)

          // Recommendations
          if (recommendations.isNotEmpty) ...[
            const SizedBox(height: 20),
            const Text('Smart Recommendations',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...recommendations.map((rec) => Card(
              child: ListTile(
                leading: const Icon(Icons.lightbulb_outline),
                title: Text(rec),
              ),
            )).toList(),
          ],

          // Recent Searches
          const SizedBox(height: 20),
          const Text('Recent Searches',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

          if (searchHistory.isEmpty)
            const Center(child: Text('No recent searches')),

          ...searchHistory.take(5).map((item) => ListTile(
            leading: const Icon(Icons.history),
            title: Text(item.query),
            trailing: Text('${item.frequency}x'),
            onTap: () => _searchMedicalInfo(item.query),
          )).toList(),

          // Symptom Tracker Card
          const SizedBox(height: 30),
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Symptom Tracker',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text('Track your symptoms over time to identify patterns'),
                  const SizedBox(height: 15),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add_chart),
                    label: const Text('Track Symptoms'),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SymptomTrackerScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _searchMedicalInfo(String query) {
    trackingRepo.addSearchQuery(query);
    // Existing search implementation
  }
}