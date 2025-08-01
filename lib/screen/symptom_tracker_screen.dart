// lib/screens/symptom_tracker_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/tracking.dart';
import '../repository/tracking_repository.dart';

class SymptomTrackerScreen extends StatefulWidget {
  const SymptomTrackerScreen({super.key});

  @override
  State<SymptomTrackerScreen> createState() => _SymptomTrackerScreenState();
}

class _SymptomTrackerScreenState extends State<SymptomTrackerScreen> {
  final _formKey = GlobalKey<FormState>();
  String _symptom = '';
  int _severity = 3;
  String _notes = '';
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Symptom Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Symptom',
                  prefixIcon: Icon(Icons.medical_services),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a symptom';
                  }
                  return null;
                },
                onSaved: (value) => _symptom = value!,
              ),

              const SizedBox(height: 20),

              Text('Severity: $_severity/5',
                  style: Theme.of(context).textTheme.titleMedium),

              Slider(
                value: _severity.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                onChanged: (value) => setState(() => _severity = value.round()),
              ),

              const SizedBox(height: 20),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Additional Notes',
                  prefixIcon: Icon(Icons.notes),
                ),
                maxLines: 3,
                onSaved: (value) => _notes = value ?? '',
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 10),
                  Text('Date: ${DateFormat.yMd().format(_selectedDate)}'),
                  const Spacer(),
                  TextButton(
                    child: const Text('Change date'),
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now().subtract(const Duration(days: 365)),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() => _selectedDate = date);
                      }
                    },
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Save Symptom Record'),
                  onPressed: _saveRecord,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveRecord() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final record = SymptomRecord(
        symptom: _symptom,
        date: _selectedDate,
        severity: _severity,
        notes: _notes,
      );

      context.read<TrackingRepository>().addSymptomRecord(record);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Symptom record saved')),
      );

      // Clear form
      _formKey.currentState!.reset();
      setState(() {
        _severity = 3;
        _selectedDate = DateTime.now();
      });
    }
  }
}