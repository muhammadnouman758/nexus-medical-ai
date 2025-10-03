// lib/models/disease_info.dart
class DiseaseInfo {
  final String name;
  final String overview;
  final List<String> symptoms;
  final List<String> causes;
  final List<String> treatments;
  final List<Medication> medications;
  final String disclaimer;
  final List<String>? imageUrls;
  final DateTime lastUpdated;

  DiseaseInfo({
    required this.name,
    required this.overview,
    required this.symptoms,
    required this.causes,
    required this.treatments,
    required this.medications,
    required this.disclaimer,
    this.imageUrls,
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

  factory DiseaseInfo.fromJson(Map<String, dynamic> json) {
    return DiseaseInfo(
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      symptoms: List<String>.from(json['symptoms'] ?? []),
      causes: List<String>.from(json['causes'] ?? []),
      treatments: List<String>.from(json['treatments'] ?? []),
      medications: (json['medications'] as List? ?? [])
          .map((m) => Medication.fromJson(m))
          .toList(),
      disclaimer: json['disclaimer'] ?? 'Consult a healthcare professional',
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'overview': overview,
      'symptoms': symptoms,
      'causes': causes,
      'treatments': treatments,
      'medications': medications.map((m) => m.toJson()).toList(),
      'disclaimer': disclaimer,
      'imageUrls': imageUrls,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}

class Medication {
  final String name;
  final String dosage;
  final String precautions;
  final String imageUrl;
  final List<String> indications;

  Medication({
    required this.name,
    required this.dosage,
    required this.precautions,
    required this.imageUrl,
    required this.indications,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      name: json['name'] ?? '',
      dosage: json['dosage'] ?? '',
      precautions: json['precautions'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      indications: List<String>.from(json['indications'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dosage': dosage,
      'precautions': precautions,
      'imageUrl': imageUrl,
      'indications': indications,
    };
  }
}