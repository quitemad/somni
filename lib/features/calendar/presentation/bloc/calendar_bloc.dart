import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somni/features/calendar/domain/usecases/calendar_get_month_usecase.dart';
import '../../domain/usecases/calendar_add_notes_usecase.dart';
import '../../domain/usecases/calendar_get_day_detalis_usecase.dart';
import '../../domain/usecases/calendar_update_task_status_usecase.dart';
import 'calendar_event.dart';
import 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final GetMonthCalendarUseCase getMonthCalendar;
  final GetDayDetailsUseCase getDayDetails;
  final AddNoteUseCase addNote;
  final UpdateTaskStatusUseCase updateTaskStatus;

  CalendarBloc({
    required this.getMonthCalendar,
    required this.getDayDetails,
    required this.addNote,
    required this.updateTaskStatus,
  }) : super(CalendarInitial()) {
    on<LoadMonthCalendar>(_onLoadMonth);
    on<SelectDay>(_onSelectDay);
    on<AddNoteEvent>(_onAddNote);
    on<UpdateTaskStatusEvent>(_onUpdateTaskStatus);
  }

  Future<void> _onLoadMonth(
      LoadMonthCalendar event,
      Emitter<CalendarState> emit,
      ) async {
    emit(CalendarLoading());

    try {
      final days = await getMonthCalendar(
        year: event.year,
        month: event.month,
      );

      emit(
        CalendarLoaded(
          days: days,
          selectedDate: DateTime(event.year, event.month, 1),
        ),
      );
    } catch (e) {
      emit(CalendarError(e.toString()));
    }
  }

  Future<void> _onSelectDay(
      SelectDay event,
      Emitter<CalendarState> emit,
      ) async {
    final currentState = state;
    if (currentState is! CalendarLoaded) return;

    emit(
      currentState.copyWith(
        selectedDate: event.date,
        isDayLoading: true,
      ),
    );

    try {
      final details = await getDayDetails(event.date);

      emit(
        currentState.copyWith(
          selectedDate: event.date,
          dayDetails: details,
          isDayLoading: false,
        ),
      );
    } catch (e) {
      emit(CalendarError(e.toString()));
    }
  }

  Future<void> _onAddNote(
      AddNoteEvent event,
      Emitter<CalendarState> emit,
      ) async {
    final currentState = state;
    if (currentState is! CalendarLoaded) return;

    try {
      await addNote(
        date: event.date,
        content: event.content,
      );

      final refreshedDetails = await getDayDetails(event.date);

      emit(
        currentState.copyWith(
          dayDetails: refreshedDetails,
        ),
      );
    } catch (e) {
      emit(CalendarError(e.toString()));
    }
  }

  Future<void> _onUpdateTaskStatus(
      UpdateTaskStatusEvent event,
      Emitter<CalendarState> emit,
      ) async {
    final currentState = state;
    if (currentState is! CalendarLoaded) return;

    try {
      await updateTaskStatus(
        taskId: event.taskId,
        isCompleted: event.isCompleted,
      );

      final refreshedDetails =
      await getDayDetails(currentState.selectedDate);

      emit(
        currentState.copyWith(
          dayDetails: refreshedDetails,
        ),
      );
    } catch (e) {
      emit(CalendarError(e.toString()));
    }
  }
}
