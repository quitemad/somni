import 'package:equatable/equatable.dart';
import '../../domain/entities/calendar_day_entity.dart';
import '../../domain/entities/day_details_entity.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object?> get props => [];
}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final List<CalendarDay> days;
  final DateTime selectedDate;
  final DayDetails? dayDetails;
  final bool isDayLoading;

  const CalendarLoaded({
    required this.days,
    required this.selectedDate,
    this.dayDetails,
    this.isDayLoading = false,
  });

  CalendarLoaded copyWith({
    List<CalendarDay>? days,
    DateTime? selectedDate,
    DayDetails? dayDetails,
    bool? isDayLoading,
  }) {
    return CalendarLoaded(
      days: days ?? this.days,
      selectedDate: selectedDate ?? this.selectedDate,
      dayDetails: dayDetails ?? this.dayDetails,
      isDayLoading: isDayLoading ?? this.isDayLoading,
    );
  }

  @override
  List<Object?> get props => [
    days,
    selectedDate,
    dayDetails,
    isDayLoading,
  ];
}

class CalendarError extends CalendarState {
  final String message;

  const CalendarError(this.message);

  @override
  List<Object?> get props => [message];
}
