// // import 'package:flutter/material.dart';
// // import 'package:sleep_chart/sleep_chart.dart';
// // import 'package:somni/chat_bot_screen.dart';
// // import 'package:table_calendar/table_calendar.dart';
// //
// // class ScheduleScreen extends StatefulWidget {
// //   const ScheduleScreen({super.key});
// //
// //   @override
// //   State<ScheduleScreen> createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<ScheduleScreen> {
// //   late Map<SleepStage, Color> stageColors = {
// //     SleepStage.light: Theme.of(context).colorScheme.primary,
// //     SleepStage.deep: Theme.of(context).colorScheme.inversePrimary,
// //     SleepStage.rem: Theme.of(context).colorScheme.inverseSurface,
// //   };
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.transparent,
// //       body: Container(
// //         decoration: BoxDecoration(
// //           image: DecorationImage(
// //             colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
// //             image: AssetImage("assets/images/bg_waves.jpg"),
// //             fit: BoxFit.cover,
// //           ),
// //         ),
// //
// //         // 🔥 NEW LAYOUT: Everything in a Stack
// //         child: Stack(
// //           children: [
// //
// //
// //
// //             // --------------------------------------------------
// //             // 3️⃣ FULL MOON ABOVE MOUNTAINS
// //             // --------------------------------------------------
// //             Positioned(
// //               left: 0,
// //               right: 0,
// //               top: 150,
// //               // bottom: 50, // adjust if needed
// //               child: Hero(
// //                 tag: "fullMoon",
// //                 child: Image.asset(
// //                   "assets/svgs/mini_moon.png",
// //                   height: 180,
// //                 ),
// //               ),
// //             ),
// //             // --------------------------------------------------
// //             // 2️⃣ MOUNTAINS ALWAYS AT BOTTOM (never shrink)
// //             // --------------------------------------------------
// //             Positioned(
// //               left: 0,
// //               right: 0,
// //               bottom: 0,
// //               child: Hero(
// //                 tag: "mountains",
// //                 child: Image.asset(
// //                   "assets/svgs/mountains.png",
// //                   fit: BoxFit.cover,
// //                 ),
// //               ),
// //             ),
// //             // --------------------------------------------------
// //             // 1️⃣ FOREGROUND CONTENT (chart + spacing)
// //             // --------------------------------------------------
// //             Positioned.fill(
// //               top: 50,
// //                 left: 5,
// //                 right: 5,
// //                 child: TableCalendar(
// //                   calendarStyle: CalendarStyle(
// //                     defaultTextStyle: TextStyle(color: Colors.white),
// //                     rowDecoration: BoxDecoration(
// //                       color: Theme.of(context).colorScheme.secondary.withAlpha(100)
// //                     )
// //                   ),
// //                     firstDay: DateTime.utc(2010, 10, 16),
// //                     lastDay: DateTime.utc(2030, 3, 14),
// //                     focusedDay: DateTime.now(),
// //                   startingDayOfWeek: StartingDayOfWeek.saturday,
// //                   weekendDays: const [DateTime.thursday, DateTime.friday],
// //                   daysOfWeekStyle: DaysOfWeekStyle(
// //                     weekdayStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold), // Monday-Friday
// //                     weekendStyle: TextStyle(color: Colors.purple), // Saturday-Sunday
// //                   ),
// //                 )
// //               ),
// //             // ),
// //             // Positioned(
// //             //   top: 20,
// //             //   right: 20,
// //             //   child: Container(
// //             //     padding: EdgeInsets.all(0),
// //             //     alignment: Alignment.center,
// //             //     width: 110,
// //             //     // height: 100,
// //             //     decoration: BoxDecoration(
// //             //       color: Theme.of(context).colorScheme.primary.withAlpha(50),
// //             //       borderRadius: BorderRadius.circular(12),
// //             //     ),
// //             //     child: Column(
// //             //       spacing: 0,
// //             //       mainAxisAlignment: MainAxisAlignment.center,
// //             //       mainAxisSize: MainAxisSize.min,
// //             //       // crossAxisAlignment: CrossAxisAlignment.start,
// //             //       children: [
// //             //         Text("80%",style: TextStyle(fontSize: 40),),
// //             //         Text("Sleep Score"),
// //             //       ],
// //             //     ),
// //             //   ),
// //             // ),
// //             // Positioned(
// //             //   top: 20,
// //             //   left: 20,
// //             //   child: Container(
// //             //     alignment: Alignment.center,
// //             //     width: 110,
// //             //     // height: 100,
// //             //     decoration: BoxDecoration(
// //             //       color: Theme.of(context).colorScheme.primary.withAlpha(50),
// //             //       borderRadius: BorderRadius.circular(12),
// //             //     ),
// //             //     child: Center(
// //             //       child: Row(
// //             //         mainAxisAlignment: MainAxisAlignment.center,
// //             //         // crossAxisAlignment: CrossAxisAlignment.start,
// //             //         children: [
// //             //           Text("87",style: TextStyle(fontSize: 50),),
// //             //           Column(
// //             //
// //             //             children: [
// //             //               Icon(Icons.heart_broken_outlined,color: Colors.red,),
// //             //               Text("bpm"),
// //             //             ],
// //             //           ),
// //             //         ],
// //             //       ),
// //             //     ),
// //             //   ),
// //             // ),
// //
// //           ],
// //         ),
// //       ),
// //
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// class ScheduleScreen extends StatefulWidget {
//   const ScheduleScreen({super.key});
//
//   @override
//   State<ScheduleScreen> createState() => _ScheduleScreenState();
// }
//
// class _ScheduleScreenState extends State<ScheduleScreen> {
//   late final Map<DateTime, List<String>> _events;
//
//   @override
//   void initState() {
//     super.initState();
//     _events = {
//       DateTime.utc(2025, 12, 2): ['Meeting at 10am', 'Call with John'],
//       DateTime.utc(2025, 12, 3): ['Gym', 'Dinner with family'],
//     };
//   }
//
//   List<String> _getEventsForDay(DateTime day) {
//     return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
//   }
//
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
//             image: AssetImage("assets/images/bg_waves.jpg"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Stack(
//           children: [
// // Moon
//             Positioned(
//               left: 0,
//               right: 0,
//               top: 150,
//               child: Hero(
//                 tag: "fullMoon",
//                 child: Image.asset(
//                   "assets/svgs/mini_moon.png",
//                   height: 180,
//                 ),
//               ),
//             ),
// // Mountains
//             Positioned(
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: Hero(
//                 tag: "mountains",
//                 child: Image.asset(
//                   "assets/svgs/mountains.png",
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
// // Calendar and events
//             Positioned.fill(
//               top: 50,
//               left: 5,
//               right: 5,
//               child: Column(
//                 children: [
//                   TableCalendar(
//                     firstDay: DateTime.utc(2010, 10, 16),
//                     lastDay: DateTime.utc(2030, 3, 14),
//                     focusedDay: _focusedDay,
//                     selectedDayPredicate: (day) {
//                       return isSameDay(_selectedDay, day);
//                     },
//                     onDaySelected: (selectedDay, focusedDay) {
//                       setState(() {
//                         _selectedDay = selectedDay;
//                         _focusedDay = focusedDay;
//                       });
//                     },
//                     startingDayOfWeek: StartingDayOfWeek.saturday,
//                     weekendDays: const [DateTime.thursday, DateTime.friday],
//                     daysOfWeekStyle: DaysOfWeekStyle(
//                       weekdayStyle:
//                       TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                       weekendStyle: TextStyle(color: Colors.purple),
//                     ),
//                     calendarStyle: CalendarStyle(
//                       defaultTextStyle: TextStyle(color: Colors.white),
//                       weekendTextStyle: TextStyle(color: Colors.purple),
//                       rowDecoration: BoxDecoration(
//                         color: Theme.of(context).colorScheme.secondary.withAlpha(100),
//                       ),
//                     ),
//                     eventLoader: _getEventsForDay,
//                   ),
//                   const SizedBox(height: 10),
// // Events list
//                   Expanded(
//                     child: _selectedDay == null
//                         ? Center(child: Text('Select a day', style: TextStyle(color: Colors.white)))
//                         : ListView(
//                       children: _getEventsForDay(_selectedDay!).map((event) {
//                         return Container(
//                           margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: Colors.blue.withOpacity(0.5),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(
//                             event,
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late final Map<DateTime, List<String>> _events;

  @override
  void initState() {
    super.initState();
    _events = {
      DateTime.utc(2025, 12, 2): ['Meeting at 10am', 'Call with John'],
      DateTime.utc(2025, 12, 3): ['Gym', 'Dinner with family'],
    };
  }

  List<String> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Future<void> _addEvent(DateTime day) async {
    final TextEditingController controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Event'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Event title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Add'),
          ),
        ],
      ),
    );

    // ```
    if (result != null && result.isNotEmpty) {
    final dayKey = DateTime.utc(day.year, day.month, day.day);
    if (_events.containsKey(dayKey)) {
    _events[dayKey]!.add(result);
    } else {
    _events[dayKey] = [result];
    }
    setState(() {});
    }
    // ```

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
            image: AssetImage("assets/images/bg_waves.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
// Moon
            Positioned(
              left: 0,
              right: 0,
              top: 150,
              child: Hero(
                tag: "fullMoon",
                child: Image.asset(
                  "assets/svgs/mini_moon.png",
                  height: 180,
                ),
              ),
            ),
// Mountains
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Hero(
                tag: "mountains",
                child: Image.asset(
                  "assets/svgs/mountains.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
// Calendar and events
            Positioned.fill(
              top: 50,
              left: 5,
              right: 5,
              child: Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    onDayLongPressed: (day, focusedDay) {
                      _addEvent(day);
                    },
                    startingDayOfWeek: StartingDayOfWeek.saturday,
                    weekendDays: const [DateTime.thursday, DateTime.friday],
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle:
                      const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      weekendStyle: const TextStyle(color: Colors.purple),
                    ),
                    calendarStyle: CalendarStyle(
                      defaultTextStyle: const TextStyle(color: Colors.white),
                      weekendTextStyle: const TextStyle(color: Colors.purple),
                      rowDecoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary.withAlpha(100),
                      ),
                      markerDecoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        shape: BoxShape.circle,
                      ),
                      markersMaxCount: 1,
                    ),
                    eventLoader: _getEventsForDay,
                  ),
                  const SizedBox(height: 10),
// Events list
                  Expanded(
                    child: _selectedDay == null
                        ? const Center(
                        child: Text('Select a day', style: TextStyle(color: Colors.white)))
                        : ListView(
                      children: _getEventsForDay(_selectedDay!).map((event) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            event,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
