// features/dashboard/presentation/widgets/week_score_chart.dart
import 'package:flutter/material.dart';
import '../../data/model/sleep_session_model.dart';

class WeekScoreChart extends StatelessWidget {
  final List<SleepSessionModel> sessions; // expected up to 7 items sorted descending (most recent first)
  const WeekScoreChart({super.key, required this.sessions});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // normalize scores to heights (0..100)
    final scores = sessions.map((s) => s.sleepScore ?? 0).toList();
    final maxScore = (scores.isEmpty) ? 100 : (scores.reduce((a, b) => a > b ? a : b).clamp(1, 100));
    return SizedBox(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(7, (i) {
          final idx = i; // we'll display reversed so earliest on left
          int score = 0;
          if (scores.length == 7) {
            score = scores[6 - i]; // reverse to show oldest left -> newest right
          } else {
            // fill from right with recent sessions
            final fillIndex = sessions.length - 1 - i;
            if (fillIndex >= 0 && fillIndex < sessions.length) {
              // score = sessions[fillIndex].sleepScore ?? 0;
              score = sessions[fillIndex].durationMinutes ?? 0;
            } else {
              score = 0;
            }
          }
          final heightFactor = (maxScore > 0) ? (score / maxScore) : 0.0;
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      heightFactor: heightFactor.clamp(0.0, 1.0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(score > 0 ? score.toString() : '-', style: const TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
          );
        }),
      ),
    );
  }
}