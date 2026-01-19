import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/model/sleep_session_model.dart';

class WeekScoreChart extends StatelessWidget {
  final List<SleepSessionModel> sessions;

  const WeekScoreChart({
    super.key,
    required this.sessions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 120,
      child: Row(
        children: List.generate(7, (i) {
          final int sessionIndex = sessions.length - 1 - i;

          int score = 0;
          DateTime? date;

          if (sessionIndex >= 0 && sessionIndex < sessions.length) {
            final session = sessions[sessionIndex];
            score = session.durationMinutes ?? 0; // 0,1,2
            date = session.date;
          }

          /// Direct mapping (NO normalization)
          final double heightFactor = switch (score) {
            0 => 0.25,
            1 => 0.55,
            2 => 0.9,
            _ => 0.25,
          };

          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      heightFactor: heightFactor,
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
                Text(
                  date != null
                      ? DateFormat('EEE').format(date)
                      : '-',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                // TextButton(onPressed: (){
                //   sessions.forEach((e) =>  Logger().f(e.durationMinutes.toString(),),);
                //
                //
                // }, child: Text("data"))

              ],
            ),
          );
        }),
      ),
    );
  }
}
