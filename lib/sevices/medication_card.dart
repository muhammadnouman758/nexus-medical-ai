// lib/widgets/medication_card.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/medication.dart';

class MedicationCard extends StatelessWidget {
  final Medication medication;

  const MedicationCard({super.key, required this.medication});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: medication.imageUrl,
            height: 120,
          ),
          Text(medication.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Dosage: ${medication.dosage}'),
          Text('Precautions: ${medication.precautions}'),
        ],
      ),
    );
  }
}