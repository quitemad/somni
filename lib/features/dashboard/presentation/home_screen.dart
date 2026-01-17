// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:somni/features/dashboard/presentation/widgets/week_score_chart.dart';
// // import '../../../navigation_util.dart';
// // import 'bloc/dashboard_bloc.dart';
// // import 'bloc/dashboard_event.dart';
// // import 'bloc/dashboard_state.dart';
// //
// // class HomeScreen extends StatefulWidget {
// //   const HomeScreen({super.key});
// //
// //   @override
// //   State<HomeScreen> createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<HomeScreen> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     // Request dashboard after build
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       final bloc = context.read<DashboardBloc>();
// //       bloc.add(LoadDashboardRequested());
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final theme = Theme.of(context);
// //     return Scaffold(
// //       backgroundColor: Colors.transparent,
// //       body: SafeArea(
// //         child: Container(
// //           decoration: BoxDecoration(
// //             image: DecorationImage(
// //               colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
// //               image: const AssetImage("assets/images/bg_plain.jpg"),
// //               fit: BoxFit.cover,
// //             ),
// //           ),
// //           child: Stack(
// //             children: [
// //               Positioned(
// //                 left: 0,
// //                 right: 0,
// //                 bottom: 50,
// //                 child: Hero(
// //                   tag: "fullMoon",
// //                   child: Image.asset(
// //                     "assets/svgs/full_moon.png",
// //                     height: 180,
// //                   ),
// //                 ),
// //               ),
// //               Positioned(
// //                 left: 0,
// //                 right: 0,
// //                 bottom: 0,
// //                 child: Hero(tag: "mountains", child: Image.asset("assets/svgs/mountains.png", fit: BoxFit.cover)),
// //               ),
// //               Positioned.fill(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.center,
// //                   children: [
// //                     const SizedBox(height: 150),
// //                     // Dashboard area
// //                     BlocBuilder<DashboardBloc, DashboardState>(
// //                       builder: (context, state) {
// //                         if (state is DashboardLoading || state is DashboardInitial) {
// //                           return SizedBox(
// //                             height: 220,
// //                             child: Center(child: CircularProgressIndicator(color: theme.colorScheme.primary)),
// //                           );
// //                         } else if (state is DashboardLoaded) {
// //                           final dashboard = state.dashboard;
// //                           final weekly = state.weeklySessions;
// //                           final bpm = state.todayMetrics != null ? (state.todayMetrics!['heart_rate'] as int?) : null;
// //                           final sleepScore = dashboard.lastSleep?.sleepScore ?? dashboard.weeklyAverageScore ?? 0;
// //                           return Column(
// //                             children: [
// //                               SizedBox(
// //                                 height: 220,
// //                                 width: MediaQuery.of(context).size.width - 50,
// //                                 child: Column(
// //                                   children: [
// //                                     // Sleep score big card and bpm card row
// //                                     Row(
// //                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                                       children: [
// //                                         // Sleep Score big
// //                                         Container(
// //                                           padding: const EdgeInsets.all(12),
// //                                           width: 160,
// //                                           decoration: BoxDecoration(
// //                                             color: theme.colorScheme.primary.withAlpha(50),
// //                                             borderRadius: BorderRadius.circular(12),
// //                                           ),
// //                                           child: Column(
// //                                             children: [
// //                                               Text(
// //                                                 '${sleepScore}',
// //                                                 style: const TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
// //                                               ),
// //                                               const SizedBox(height: 4),
// //                                               const Text('Sleep Score', style: TextStyle(color: Colors.white70)),
// //                                             ],
// //                                           ),
// //                                         ),
// //                                         // BPM small
// //                                         Container(
// //                                           alignment: Alignment.center,
// //                                           padding: const EdgeInsets.all(12),
// //                                           width: 160,
// //                                           height:120,
// //                                           decoration: BoxDecoration(
// //                                             color: theme.colorScheme.primary.withAlpha(50),
// //                                             borderRadius: BorderRadius.circular(12),
// //                                           ),
// //                                           child: Column(
// //                                             crossAxisAlignment: .center,
// //                                             mainAxisAlignment: .center,
// //                                             children: [
// //                                               Row(
// //                                                 mainAxisAlignment: .spaceEvenly,
// //                                                 children: [
// //                                                   Text(
// //                                                     bpm != null ? bpm.toString() : '-',
// //                                                     style: const TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
// //                                                   ),
// //                                                   Column(
// //                                                     children: const [
// //                                                       Icon(Icons.heart_broken_outlined, color: Colors.red),
// //                                                       Text("bpm"),
// //                                                     ],
// //                                                   ),
// //
// //                                                 ],
// //                                               ),
// //                                             ],
// //                                           ),
// //                                         ),
// //                                       ],
// //                                     ),
// //                                     const SizedBox(height: 12),
// //                                     // Week chart
// //                                     Expanded(
// //                                       child: WeekScoreChart(sessions: weekly),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ],
// //                           );
// //                         } else if (state is DashboardError) {
// //                           return SizedBox(
// //                             height: 220,
// //                             child: Center(child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.red))),
// //                           );
// //                         } else {
// //                           return const SizedBox.shrink();
// //                         }
// //                       },
// //                     ),
// //                     const Spacer(),
// //                   ],
// //                 ),
// //               ),
// //               Positioned(
// //                 top: 20,
// //                 right: 20,
// //                 child: Container(
// //                   padding: const EdgeInsets.all(0),
// //                   alignment: Alignment.center,
// //                   width: 110,
// //                   decoration: BoxDecoration(
// //                     color: theme.colorScheme.primary.withAlpha(50),
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: const [
// //                       // kept this small since main score is shown above
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //               // Positioned(
// //               //   top: 20,
// //               //   left: 20,
// //               //   child: Container(
// //               //     alignment: Alignment.center,
// //               //     width: 110,
// //               //     decoration: BoxDecoration(
// //               //       color: theme.colorScheme.primary.withAlpha(50),
// //               //       borderRadius: BorderRadius.circular(12),
// //               //     ),
// //               //     child: Center(
// //               //       child: Row(
// //               //         mainAxisAlignment: MainAxisAlignment.center,
// //               //         children: [
// //               //           const Text("—", style: TextStyle(fontSize: 26, color: Colors.white)),
// //               //           Column(
// //               //             children: const [
// //               //               Icon(Icons.heart_broken_outlined, color: Colors.red),
// //               //               Text("bpm"),
// //               //             ],
// //               //           ),
// //               //         ],
// //               //       ),
// //               //     ),
// //               //   ),
// //               // ),
// //             ],
// //           ),
// //         ),
// //       ),
// //       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
// //       floatingActionButton: Container(
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(50),
// //           boxShadow: [
// //             BoxShadow(blurRadius: 20, offset: Offset(0, 0), color: theme.colorScheme.primary),
// //           ],
// //         ),
// //         width: 200,
// //         height: 100,
// //         child: FloatingActionButton(
// //           foregroundColor: theme.colorScheme.inversePrimary,
// //           backgroundColor: Colors.transparent,
// //           onPressed: () => NavigationUtil.goTo(context, '/chat'),
// //           child: const Text("Start Sleep", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:somni/features/dashboard/presentation/widgets/week_score_chart.dart';
// import '../../../navigation_util.dart';
// import 'bloc/dashboard_bloc.dart';
// import 'bloc/dashboard_event.dart';
// import 'bloc/dashboard_state.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Request dashboard after build
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // Make sure a DashboardBloc provider exists above this widget (ShellRoute or route-level BlocProvider)
//       final bloc = context.read<DashboardBloc>();
//       bloc.add(LoadDashboardRequested());
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
//               image: const AssetImage("assets/images/bg_plain.jpg"),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Stack(
//             children: [
//               Positioned(
//                 left: 0,
//                 right: 0,
//                 bottom: 50,
//                 child: Hero(
//                   tag: "fullMoon",
//                   child: Image.asset(
//                     "assets/svgs/full_moon.png",
//                     height: 180,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 0,
//                 right: 0,
//                 bottom: 0,
//                 child: Hero(
//                   tag: "mountains",
//                   child: Image.asset("assets/svgs/mountains.png", fit: BoxFit.cover),
//                 ),
//               ),
//               Positioned.fill(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 150),
//                     // Dashboard area
//                     BlocBuilder<DashboardBloc, DashboardState>(
//                       builder: (context, state) {
//                         if (state is DashboardLoading || state is DashboardInitial) {
//                           return SizedBox(
//                             height: 220,
//                             child: Center(child: CircularProgressIndicator(color: theme.colorScheme.primary)),
//                           );
//                         } else if (state is DashboardLoaded) {
//                           final dashboard = state.dashboard;
//                           final weekly = state.weeklySessions;
//                           final int? bpm = state.todayMetrics != null ? (state.todayMetrics!['heart_rate'] as int?) : null;
//                           final sleepScore = dashboard.lastSleep?.sleepScore ?? dashboard.weeklyAverageScore ?? 0;
//                           return Column(
//                             children: [
//                               SizedBox(
//                                 height: 220,
//                                 width: MediaQuery.of(context).size.width - 50,
//                                 child: Column(
//                                   children: [
//                                     // Sleep score big card and bpm card row
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         // Sleep Score big
//                                         Container(
//                                           padding: const EdgeInsets.all(12),
//                                           width: 160,
//                                           decoration: BoxDecoration(
//                                             color: theme.colorScheme.primary.withAlpha(50),
//                                             borderRadius: BorderRadius.circular(12),
//                                           ),
//                                           child: Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               Text(
//                                                 '$sleepScore',
//                                                 style: const TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
//                                               ),
//                                               const SizedBox(height: 4),
//                                               const Text('Sleep Score', style: TextStyle(color: Colors.white70)),
//                                             ],
//                                           ),
//                                         ),
//                                         // BPM small
//                                         Container(
//                                           alignment: Alignment.center,
//                                           padding: const EdgeInsets.all(12),
//                                           width: 160,
//                                           height: 120,
//                                           decoration: BoxDecoration(
//                                             color: theme.colorScheme.primary.withAlpha(50),
//                                             borderRadius: BorderRadius.circular(12),
//                                           ),
//                                           child: Column(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             crossAxisAlignment: CrossAxisAlignment.center,
//                                             children: [
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                 children: [
//                                                   Text(
//                                                     bpm != null ? bpm.toString() : '-',
//                                                     style: const TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
//                                                   ),
//                                                   Column(
//                                                     mainAxisSize: MainAxisSize.min,
//                                                     children: const [
//                                                       Icon(Icons.heart_broken_outlined, color: Colors.red),
//                                                       SizedBox(height: 4),
//                                                       Text("bpm", style: TextStyle(color: Colors.white70)),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 12),
//                                     // Week chart
//                                     Expanded(
//                                       child: WeekScoreChart(sessions: weekly),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           );
//                         } else if (state is DashboardError) {
//                           return SizedBox(
//                             height: 220,
//                             child: Center(child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.red))),
//                           );
//                         } else {
//                           return const SizedBox.shrink();
//                         }
//                       },
//                     ),
//                     const Spacer(),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 top: 20,
//                 right: 20,
//                 child: Container(
//                   padding: const EdgeInsets.all(0),
//                   alignment: Alignment.center,
//                   width: 110,
//                   decoration: BoxDecoration(
//                     color: theme.colorScheme.primary.withAlpha(50),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       // kept this small since main score is shown above
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(50),
//           boxShadow: [
//             BoxShadow(blurRadius: 20, offset: const Offset(0, 0), color: theme.colorScheme.primary),
//           ],
//         ),
//         width: 200,
//         height: 100,
//         child: FloatingActionButton(
//           foregroundColor: theme.colorScheme.inversePrimary,
//           backgroundColor: Colors.transparent,
//           onPressed: () => NavigationUtil.goTo(context, '/chat'),
//           child: const Text("Start Sleep", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:somni/features/dashboard/data/model/sleep_session_model.dart';

import '../../sleep/data/repositories/sleep_repository.dart';
import 'widgets/week_score_chart.dart';
import '../../../navigation_util.dart';
import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_event.dart';
import 'bloc/dashboard_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GetIt _getIt = GetIt.instance;

  // Tracking state
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  DateTime? _startTime;
  int? _sessionId;
  bool _loadingSession = true;
  bool _saving = false;

 final  List<SleepSessionModel> weekly =[];

  SleepRepository get _sleepRepo => _getIt<SleepRepository>();

  @override
  void initState() {
    super.initState();
    // Request dashboard after build (HomeScreen still uses DashboardBloc)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // trigger dashboard load if provider exists
      try {
        context.read<DashboardBloc>().add(LoadDashboardRequested());
      } catch (_) {}
      _prepareSessionState();
    });
  }

  Future<void> _prepareSessionState() async {
    setState(() => _loadingSession = true);
    try {
      final ongoing = await _sleepRepo.getOngoingSession();
      if (ongoing != null) {
        final startStr = ongoing['start_time'] as String?;
        final parsed = startStr != null ? DateTime.tryParse(startStr) : null;
        setState(() {
          _sessionId = (ongoing['id'] is int) ? ongoing['id'] as int : int.tryParse('${ongoing['id']}');
          _startTime = parsed ?? DateTime.now();
          _elapsed = DateTime.now().difference(_startTime!);
        });
        _startTimer();
      } else {
        setState(() {
          _sessionId = null;
          _startTime = null;
          _elapsed = Duration.zero;
        });
      }
    } catch (e) {
      // on error, just show UI and allow start
      debugPrint('Failed to check ongoing session: $e');
    } finally {
      setState(() => _loadingSession = false);
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_startTime == null) return;
      setState(() => _elapsed = DateTime.now().difference(_startTime!));
    });
  }

  Future<void> _startSession() async {
    print("started");
    setState(() {
      _saving = true;
    });
    try {
      final id = await _sleepRepo.startSessionAndEnsureDailyMetrics();
      setState(() {
        _sessionId = id;
        _startTime = DateTime.now();
        _elapsed = Duration.zero;
      });
      _startTimer();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to start session: $e')));
    } finally {
      setState(() => _saving = false);
    }
  }

  Future<void> _stopSession() async {
    if (_sessionId == null) return;
    setState(() => _saving = true);
    try {
      await _sleepRepo.stopSession(_sessionId!);
      // refresh dashboard to show updated last sleep / scores
      try {
        context.read<DashboardBloc>().add(LoadDashboardRequested());
      } catch (_) {}
      // Reset local UI state
      setState(() {
        _sessionId = null;
        _startTime = null;
        _elapsed = Duration.zero;
      });
      _timer?.cancel();
      // optional: show brief confirmation
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          elevation: 10,
          // padding: EdgeInsets.only(bottom: 50),
          // margin: EdgeInsets.only(bottom: 10),
          content: Text(
          'Sleep session saved,\n You have slept for ${weekly.first
              .durationMinutes??0} minutes\nYour sleep data :\nscore:${weekly.first
              .sleepScore??0}\nQuality:${weekly.first.sleepQuality??0}')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to stop session: $e')));
    } finally {
      setState(() => _saving = false);
    }
  }

  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    if (h > 0) return '${h.toString().padLeft(2,'0')}:${m.toString().padLeft(2,'0')}:${s.toString().padLeft(2,'0')}';
    return '${m.toString().padLeft(2,'0')}:${s.toString().padLeft(2,'0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    final theme = Theme.of(context);
    if (_loadingSession) {
      return FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.grey,
        child: const CircularProgressIndicator(color: Colors.white),
      );
    }

    if (_sessionId != null) {
      // Currently tracking -> show Stop button with elapsed time
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [BoxShadow(blurRadius: 20, offset: const Offset(0, 0), color: theme.colorScheme.primary)],
        ),
        width: 220,
        height: 100,
        child: FloatingActionButton.extended(
          foregroundColor: theme.colorScheme.inversePrimary,
          backgroundColor: Colors.transparent,
          onPressed: _saving ? null : _stopSession,
          icon: _saving ? const CircularProgressIndicator() : const Icon(Icons.stop),
          label: Text(_saving ? 'Saving...' : _formatDuration(_elapsed), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      );
    }

    // Not tracking -> show Start button
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [BoxShadow(blurRadius: 20, offset: const Offset(0, 0), color: theme.colorScheme.primary)],
      ),
      width: 200,
      height: 100,
      child: FloatingActionButton(
        foregroundColor: theme.colorScheme.inversePrimary,
        backgroundColor: Colors.transparent,
        onPressed: _saving ? null : _startSession,
        child: const Text("Start Sleep", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              image: const AssetImage("assets/images/bg_plain.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 50,
                child: Hero(
                  tag: "fullMoon",
                  child: Image.asset(
                    "assets/svgs/full_moon.png",
                    height: 180,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Hero(tag: "mountains", child: Image.asset("assets/svgs/mountains.png", fit: BoxFit.cover)),
              ),
              Positioned.fill(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 150),
                    // Dashboard area
                    BlocBuilder<DashboardBloc, DashboardState>(
                      builder: (context, state) {
                        if (state is DashboardLoading || state is DashboardInitial) {
                          return SizedBox(
                            height: 220,
                            child: Center(child: CircularProgressIndicator(color: theme.colorScheme.primary)),
                          );
                        } else if (state is DashboardLoaded) {
                          final dashboard = state.dashboard;
                          weekly.addAll(state.weeklySessions);
                          final int? bpm = state.todayMetrics != null ? (state.todayMetrics!['heart_rate'] as int?) : null;
                          // final sleepScore = dashboard.lastSleep?.sleepScore ?? dashboard.weeklyAverageScore ?? 0;
                          final sleepScore = (weekly.fold<int>(0, (a,b)=>a+(b.sleepScore??0))/weekly.length).ceil();
                          return Column(
                            children: [
                              SizedBox(
                                height: 220,
                                width: MediaQuery.of(context).size.width - 50,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Sleep Score big
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          width: 160,
                                          decoration: BoxDecoration(
                                            color: theme.colorScheme.primary.withAlpha(50),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                 softWrap: true,
                                                '$sleepScore',
                                                style: const TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(height: 4),
                                              const Text('Sleep Score', style: TextStyle(color: Colors.white70)),
                                            ],
                                          ),
                                        ),
                                        // BPM small
                                        Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(12),
                                          width: 160,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            color: theme.colorScheme.primary.withAlpha(50),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(
                                                    bpm != null ? bpm.toString() : '-',
                                                    style: const TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
                                                  ),
                                                  Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: const [
                                                      Icon(Icons.heart_broken_outlined, color: Colors.red),
                                                      SizedBox(height: 4),
                                                      Text("bpm", style: TextStyle(color: Colors.white70)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // const SizedBox(height: 50),
                                    // Week chart
                                    Expanded(
                                      child: WeekScoreChart(sessions: weekly),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else if (state is DashboardError) {
                          return SizedBox(
                            height: 220,
                            child: Center(child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.red))),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(0),
                  alignment: Alignment.center,
                  width: 110,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withAlpha(50),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      // kept this small since main score is shown above
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }
}