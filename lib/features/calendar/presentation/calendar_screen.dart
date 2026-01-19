import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:somni/features/calendar/presentation/widgets/card_tile.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/util/injection.dart';
import 'bloc/calendar_bloc.dart';
import 'bloc/calendar_event.dart';
import 'bloc/calendar_state.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CalendarBloc>()
        ..add(
          LoadMonthCalendar(
            year: DateTime.now().year,
            month: DateTime.now().month,
          ),
        ),
      child: const _CalendarView(),
    );
  }
}

class _CalendarView extends StatefulWidget {
  const _CalendarView();

  @override
  State<_CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<_CalendarView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Future<void> _addNote(BuildContext context, DateTime day) async {
    final controller = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add Note'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Write your note'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(dialogContext).pop(controller.text),
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      context.read<CalendarBloc>().add(
        AddNoteEvent(date: day, content: result),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Colors.black54,
              BlendMode.darken,
            ),
            image: const AssetImage("assets/images/bg_waves.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // 🌙 Moon
            Positioned(
              top: 150,
              left: 0,
              right: 0,
              child: Hero(
                tag: "fullMoon",
                child: Image.asset(
                  "assets/svgs/mini_moon.png",
                  height: 180,
                ),
              ),
            ),

            // 🏔 Mountains
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Hero(
                tag: "mountains",
                child: Image.asset("assets/svgs/mountains.png"),
              ),
            ),

            // 📅 Calendar + Details
            Positioned.fill(
              top: 50,
              left: 5,
              right: 5,
              child: BlocBuilder<CalendarBloc, CalendarState>(
                builder: (context, state) {
                  if (state is CalendarLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is CalendarLoaded) {
                    final details = state.dayDetails;

                    return Column(
                      children: [
                        TableCalendar(
                          firstDay: DateTime.utc(2010, 1, 1),
                          lastDay: DateTime.utc(2030, 12, 31),
                          focusedDay: _focusedDay,
                          selectedDayPredicate: (day) =>
                              isSameDay(_selectedDay, day),
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });

                            context.read<CalendarBloc>().add(
                              SelectDay(selectedDay),
                            );
                          },
                          onDayLongPressed: (day, _) {
                            _addNote(context, day);
                          },
                          startingDayOfWeek:
                          StartingDayOfWeek.saturday,
                          weekendDays: const [
                            DateTime.thursday,
                            DateTime.friday,
                          ],
                          eventLoader: (day) {
                            final hasSleep = state.days.any(
                                  (d) =>
                              isSameDay(d.date, day) &&
                                  d.sleepScore != null,
                            );
                            return hasSleep ? ['sleep'] : [];
                          },
                          calendarStyle: const CalendarStyle(
                            defaultTextStyle:
                            TextStyle(color: Colors.white),
                            weekendTextStyle:
                            TextStyle(color: Colors.purple),
                            markerDecoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              shape: BoxShape.circle,
                            ),
                            markersMaxCount: 1,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // 📋 Day details
                        Expanded(
                          child: details == null
                              ? const Center(
                            child: Text(
                              'Select a day',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                              : ListView(
                            children: [
                              // Notes
                              ...details.notes.map(
                                    (note) => CardTile(
                                  icon: Icons.note,
                                  text: note.content,
                                ),
                              ),

                              // Tasks
                              ...details.tasks.map(
                                    (task) => CheckboxListTile(
                                  value: task.isCompleted,
                                  title: Text(
                                    task.title,
                                    // task.isCompleted.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    Logger().f(value);
                                    context
                                        .read<CalendarBloc>()
                                        .add(
                                      UpdateTaskStatusEvent(
                                        taskId: task.id ??0,
                                        isCompleted:
                                        value ?? false,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }

                  if (state is CalendarError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
