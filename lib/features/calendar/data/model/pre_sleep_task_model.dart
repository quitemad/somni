
import '../../domain/entities/pre_sleep_task_entity.dart';

class PreSleepTaskModel {
  final int? id;
  final String title;
  final bool? isCompleted;

  PreSleepTaskModel({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  factory PreSleepTaskModel.fromJson(Map<String, dynamic> json) {
    // Logger().f(json['task_id']);
    return PreSleepTaskModel(
      id: json['task_id'] == null ? 0 : int.tryParse(json['task_id'].toString()),
      title: json['title'],
      isCompleted: json['completed'],
    );
  }

  PreSleepTask toEntity() {
    return PreSleepTask(
      id: id,
      title: title,
      isCompleted: isCompleted,
    );
  }
}
