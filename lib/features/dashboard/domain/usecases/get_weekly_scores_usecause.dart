// features/dashboard/domain/usecases/get_weekly_scores_usecase.dart

import '../../data/model/sleep_session_model.dart';
import '../reposiotries/dashboard_repository.dart';

class GetWeeklyScoresUseCase {
  final DashboardRepository repository;
  GetWeeklyScoresUseCase(this.repository);

  /// Retrieves the most recent sleep sessions (page 1) and returns up to 7 scores (date, score)
  Future<List<SleepSessionModel>> call({int page = 1}) async {
    final sessions = await repository.listSleepSessions(page: page);
    // Sort by date descending then take up to 7
    sessions.sort((a, b) {
      final da = a.date ?? DateTime.fromMillisecondsSinceEpoch(0);
      final db = b.date ?? DateTime.fromMillisecondsSinceEpoch(0);
      return db.compareTo(da);
    });
    return sessions.take(7).toList();
  }
}