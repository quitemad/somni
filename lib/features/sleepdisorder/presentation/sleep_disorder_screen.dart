import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/sleep_disorder_bloc.dart';
import 'bloc/sleep_disorder_event.dart';
import 'bloc/sleep_disorder_state.dart';

class SleepDisorderScreen extends StatefulWidget {
  const SleepDisorderScreen({super.key});

  @override
  State<SleepDisorderScreen> createState() => _SleepDisorderScreenState();
}

class _SleepDisorderScreenState extends State<SleepDisorderScreen> {
  final _age = TextEditingController();
  final _occupation = TextEditingController();
  final _sleepDuration = TextEditingController();
  final _sleepQuality = TextEditingController();
  final _activity = TextEditingController();
  final _stress = TextEditingController();
  final _heartRate = TextEditingController();
  final _bloodPressure = TextEditingController();
  final _steps = TextEditingController();

  String gender = 'male';
  String bmi = 'normal';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_waves.jpg'),
            fit: BoxFit.cover,
            colorFilter:
            ColorFilter.mode(Colors.black54, BlendMode.darken),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Text(
                'Sleep Disorder Detection',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              _input(_age, 'Age',null),
              _dropdown(
                value: gender,
                items: const ['male', 'female'],
                label: 'Gender',
                onChanged: (v) => setState(() => gender = v!),
              ),
              _input(_occupation, 'Occupation',TextInputType.text),
              _input(_sleepDuration, 'Sleep Duration (hours)',null),
              _input(_sleepQuality, 'Sleep Quality (1–5)',null),
              _input(_activity, 'Physical Activity Level',null),
              _input(_stress, 'Stress Level (1–10)',null),
              _dropdown(
                value: bmi,
                items: const ['underweight', 'normal', 'overweight'],
                label: 'BMI Category',
                onChanged: (v) => setState(() => bmi = v!),
              ),
              _input(_heartRate, 'Heart Rate',null),
              _input(_bloodPressure, 'Blood Pressure',null),
              _input(_steps, 'Daily Steps',null),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  context.read<SleepDisorderBloc>().add(
                    DetectSleepDisorderEvent({
                      "date":'2026-12-30',
                      // DateTime.now().toIso8601String().split('T').first,
                      "gender": gender,
                      "age": int.parse(_age.text),
                      "occupation": _occupation.text,
                      "sleep_duration": int.parse(_sleepDuration.text),
                      "quality_of_sleep":
                      int.parse(_sleepQuality.text),
                      "physical_activity_level":
                      int.parse(_activity.text),
                      "stress_level": int.parse(_stress.text),
                      "bmi_category": bmi,
                      "heart_rate": int.parse(_heartRate.text),
                      "blood_pressure":
                      int.parse(_bloodPressure.text),
                      "daily_steps": int.parse(_steps.text),
                    }),
                  );
                },
                child: const Text('Analyze Sleep'),
              ),

              const SizedBox(height: 30),

              BlocBuilder<SleepDisorderBloc, SleepDisorderState>(
                builder: (context, state) {
                  if (state is SleepDisorderLoading) {
                    return const CircularProgressIndicator();
                  }

                  if (state is SleepDisorderLoaded) {
                    final r = state.result;

                    final color =
                    r.disorder == 'no_sleep_disorder'
                        ? Colors.green
                        : r.disorder == 'insomnia'
                        ? Colors.orange
                        : Colors.red;

                    return Card(
                      color: color.withOpacity(0.85),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              r.disorder,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${r.readableMessage}',
                              style: const TextStyle(
                                  color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (state is SleepDisorderError) {
                    return Text(
                      "please try again tomorrow",
                      style:
                      const TextStyle(color: Colors.redAccent),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(TextEditingController c, String hint, TextInputType? type) {
    type ??= TextInputType.number;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        keyboardType: type,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          filled: true,
          fillColor: Colors.black45,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _dropdown({
    required String value,
    required List<String> items,
    required String label,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: value,
        dropdownColor: Colors.black87,
        style: const TextStyle(color: Colors.white),
        items: items
            .map(
              (e) => DropdownMenuItem(
            value: e,
            child: Text(e.toUpperCase()),
          ),
        )
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.black45,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
