// lib/repositories/medication_repository.dart
import '../model/medication.dart';

class MedicationRepository {
  final List<Medication> _medications = const [
    Medication(
      name: 'Ibuprofen',
      dosage: '200-400mg every 4-6 hours',
      precautions: 'Take with food, avoid alcohol',
      imageUrl: 'https://example.com/ibuprofen.jpg',
      indications: ['Pain relief', 'Fever reduction', 'Inflammation'],
    ),
    Medication(
      name: 'Amoxicillin',
      dosage: '500mg every 8 hours',
      precautions: 'Complete full course, may cause diarrhea',
      imageUrl: 'https://example.com/amoxicillin.jpg',
      indications: ['Bacterial infections', 'Sinusitis', 'Pneumonia'],
    ),
    // Add more medications
  ];

  List<Medication> getMedicationsForCondition(String condition) {
    return _medications.where((med) =>
        med.indications.any((indication) =>
            indication.toLowerCase().contains(condition.toLowerCase()))).toList();
  }
}