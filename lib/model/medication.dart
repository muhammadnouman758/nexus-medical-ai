// lib/models/medication.dart
class Medication {
  final String name;
  final String dosage;
  final String precautions;
  final String imageUrl;
  final List<String> indications;

  const Medication({
    required this.name,
    required this.dosage,
    required this.precautions,
    required this.imageUrl,
    required this.indications,
  });
}