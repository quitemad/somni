// // import 'package:flutter/material.dart';
// // import 'package:sleep_chart/sleep_chart.dart';
// // import 'package:somni/chat_bot_screen.dart';
// //
// // class HomeScreen extends StatefulWidget {
// //   const HomeScreen({super.key});
// //
// //   // final String title;
// //
// //   @override
// //   State<HomeScreen> createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<HomeScreen> {
// //   final Map<SleepStage, Color> stageColors = {
// //     SleepStage.light: Color(0xFF4870F3), // 浅蓝色
// //     SleepStage.deep: Color(0xFF21B2A1), // 青色
// //     SleepStage.rem: Color(0xFFFCD166), // 黄色
// //   };
// //   int _counter = 0;
// //
// //   void _incrementCounter() {
// //     setState(() {
// //
// //       _counter++;
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //
// //     return Scaffold(
// //       backgroundColor: Colors.transparent,
// //       body: SafeArea(
// //         child: Container(
// //           decoration: BoxDecoration(
// //             image: DecorationImage(
// //               colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
// //
// //               image: AssetImage("assets/images/bg_plain.jpg"),
// //               fit: BoxFit.cover,
// //             ),
// //           ),
// //           child: SizedBox.expand(
// //             child: Column(
// //               // mainAxisAlignment: MainAxisAlignment.start,
// //               children: [
// //                 // Spacer(flex: 10,),
// //                 const SizedBox(height: 100), // optional top padding
// //                    SizedBox(
// //                     height: 150,
// //                     width: MediaQuery.of(context).size.width-50,
// //                     child: SleepDurationChartWidget(
// //                       startTime: DateTime.now(),
// //                       endTime: DateTime.now().add(Duration(minutes: 5)),
// //                       heightUnit: 1/8.0,
// //                       titleHeight: 10,
// //                       titleGap:10,
// //                       xAxisTitleOffset: 0,
// //                       xAxisTitleHeight: 0,
// //                       bgColor: Colors.transparent,
// //                       details: [
// //
// //                         SleepDetailChart(
// //                           model: SleepStage.light,
// //                           width: 5,
// //                           startTime: DateTime.now(),
// //                           endTime: DateTime.now().add(Duration(minutes: 5)),
// //                           duration: 5,
// //                         ),
// //                         SleepDetailChart(
// //                           model: SleepStage.deep,
// //                           width: 5,
// //                           startTime: DateTime.now().add(Duration(minutes: 5)),
// //                           endTime: DateTime.now().add(Duration(minutes: 10)),
// //                           duration: 5,
// //                         ),
// //                         SleepDetailChart(
// //                           model: SleepStage.rem,
// //                           width: 40,
// //                           startTime: DateTime.now().add(Duration(minutes: 10)),
// //                           endTime: DateTime.now().add(Duration(minutes: 50)),
// //                           duration: 40,
// //                         ),
// //                         SleepDetailChart(
// //                           model: SleepStage.light,
// //                           width: 68,
// //                           startTime: DateTime.now().add(Duration(minutes: 50)),
// //                           endTime: DateTime.now().add(Duration(minutes: 118)),
// //                           duration: 68,
// //                         ),
// //                         SleepDetailChart(
// //                           model: SleepStage.deep,
// //                           width: 42,
// //                           startTime: DateTime.now().add(Duration(minutes: 118)),
// //                           endTime: DateTime.now().add(Duration(minutes: 160)),
// //                           duration: 42,
// //                         ),
// //                         SleepDetailChart(
// //                           model: SleepStage.rem,
// //                           width: 35,
// //                           startTime: DateTime.now().add(Duration(minutes: 160)),
// //                           endTime: DateTime.now().add(Duration(minutes: 195)),
// //                           duration: 35,
// //                         ),
// //                         SleepDetailChart(
// //                           model: SleepStage.light,
// //                           width: 32,
// //                           startTime: DateTime.now().add(Duration(minutes: 195)),
// //                           endTime: DateTime.now().add(Duration(minutes: 227)),
// //                           duration: 32,
// //                         ),
// //                         SleepDetailChart(
// //                           model: SleepStage.deep,
// //                           width: 33,
// //                           startTime: DateTime.now().add(Duration(minutes: 227)),
// //                           endTime: DateTime.now().add(Duration(minutes: 260)),
// //                           duration: 33,
// //                         ),
// //                       ],
// //                       stageColors: stageColors,
// //                       sleepStageStyles: [
// //                         SleepStageStyle(
// //                           gradientColor: [Color(0xFF4870F3), Color(0xFF21B2A1)],
// //                           value: SleepStageStyleValue.deepAndLight,
// //                         ),
// //                         SleepStageStyle(
// //                           gradientColor: [Color(0xFFFCD166), Color(0xFF21B2A1)],
// //                           value: SleepStageStyleValue.deepAndRem,
// //                         ),
// //                         SleepStageStyle(
// //                           gradientColor: [Color(0xFFFCD169), Color(0xFF4870F3)],
// //                           value: SleepStageStyleValue.lightAndRem,
// //                         ),
// //                       ],
// //
// //                     ),
// //                                    ),
// //
// //
// //                 Expanded(
// //                   // fit: FlexFit,
// //                   child: Stack(
// //                     // fit: StackFit.passthrough,
// //                     alignment: Alignment.bottomCenter,
// //                     children: [
// //                       Hero(tag: "fullMoon", child:Image.asset("assets/svgs/full_moon.png")),
// //                       Hero(tag:"mountains",child: Image.asset("assets/svgs/mountains.png")),
// //
// //                     ],
// //
// //                   ),
// //                 ),
// //
// //                 // const Text('You have pushed the button this many times:'),
// //                 // Text(
// //                 //   '$_counter',
// //                 //   // style: Theme.of(context).textTheme.headlineMedium,
// //                 // ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         // onPressed: _incrementCounter,
// //         // onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => PageTwo(),)),
// //         onPressed: (){
// //           Navigator.push(
// //             context,
// //             PageRouteBuilder(
// //               transitionDuration: Duration(milliseconds: 1200), // ⬅️ SLOWER
// //               reverseTransitionDuration: Duration(milliseconds: 1200),
// //               pageBuilder: (_, __, ___) => ChatBotScreen(),
// //             ),
// //           );
// //         },
// //         tooltip: 'Increment',
// //         child: const Icon(Icons.add),
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:sleep_chart/sleep_chart.dart';
// import 'package:somni/chat_bot_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late Map<SleepStage, Color> stageColors = {
//     SleepStage.light: Theme.of(context).colorScheme.primary,
//     SleepStage.deep: Theme.of(context).colorScheme.inversePrimary,
//     SleepStage.rem: Theme.of(context).colorScheme.inverseSurface,
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
//               image: AssetImage("assets/images/bg_plain.jpg"),
//               fit: BoxFit.cover,
//             ),
//           ),
//
//           // 🔥 NEW LAYOUT: Everything in a Stack
//           child: Stack(
//             children: [
//
//
//
//               // --------------------------------------------------
//               // 3️⃣ FULL MOON ABOVE MOUNTAINS
//               // --------------------------------------------------
//               Positioned(
//                 left: 0,
//                 right: 0,
//                 bottom: 50, // adjust if needed
//                 child: Hero(
//                   tag: "fullMoon",
//                   child: Image.asset(
//                     "assets/svgs/full_moon.png",
//                     height: 180,
//                   ),
//                 ),
//               ),
//               // --------------------------------------------------
//               // 2️⃣ MOUNTAINS ALWAYS AT BOTTOM (never shrink)
//               // --------------------------------------------------
//               Positioned(
//                 left: 0,
//                 right: 0,
//                 bottom: 0,
//                 child: Hero(
//                   tag: "mountains",
//                   child: Image.asset(
//                     "assets/svgs/mountains.png",
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               // --------------------------------------------------
//               // 1️⃣ FOREGROUND CONTENT (chart + spacing)
//               // --------------------------------------------------
//               Positioned.fill(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(height: 150),
//
//                     // Chart
//                     SizedBox(
//                       height: 200,
//                       width: MediaQuery.of(context).size.width - 50,
//                       child: SleepDurationChartWidget(
//                         startTime: DateTime.now(),
//                         endTime: DateTime.now().add(Duration(minutes: 5)),
//                         heightUnit: 1 / 8.0,
//                         titleHeight: 10,
//                         titleGap: 10,
//                         xAxisTitleOffset: 0,
//                         xAxisTitleHeight: 0,
//                         bottomInfoTextStyle: TextStyle(color: Colors.white),
//                         horizontalLineStyle: LineStyle(width: 5, space: 2),
//                         verticalLineStyle: LineStyle(width: 5, space: 2),
//                         dividerPaintStyle: PaintStyle(color: Colors.black,
//                             strokeWidth: 3,
//                             style: PaintingStyle.fill,
//                             strokeCap: StrokeCap.round),
//                         bgColor: Theme.of(context).colorScheme.inversePrimary.withAlpha(100),
//                         details: [
//                           SleepDetailChart(
//                             model: SleepStage.light,
//                             width: 5,
//                             startTime: DateTime.now(),
//                             endTime: DateTime.now().add(Duration(minutes: 5)),
//                             duration: 5,
//                           ),
//                           SleepDetailChart(
//                             model: SleepStage.deep,
//                             width: 5,
//                             startTime: DateTime.now().add(Duration(minutes: 5)),
//                             endTime: DateTime.now().add(Duration(minutes: 10)),
//                             duration: 5,
//                           ),
//                           SleepDetailChart(
//                             model: SleepStage.rem,
//                             width: 40,
//                             startTime: DateTime.now().add(Duration(minutes: 10)),
//                             endTime: DateTime.now().add(Duration(minutes: 50)),
//                             duration: 40,
//                           ),
//                           SleepDetailChart(
//                             model: SleepStage.light,
//                             width: 68,
//                             startTime: DateTime.now().add(Duration(minutes: 50)),
//                             endTime: DateTime.now().add(Duration(minutes: 118)),
//                             duration: 68,
//                           ),
//                           SleepDetailChart(
//                             model: SleepStage.deep,
//                             width: 42,
//                             startTime: DateTime.now().add(Duration(minutes: 118)),
//                             endTime: DateTime.now().add(Duration(minutes: 160)),
//                             duration: 42,
//                           ),
//                           SleepDetailChart(
//                             model: SleepStage.rem,
//                             width: 35,
//                             startTime: DateTime.now().add(Duration(minutes: 160)),
//                             endTime: DateTime.now().add(Duration(minutes: 195)),
//                             duration: 35,
//                           ),
//                           SleepDetailChart(
//                             model: SleepStage.light,
//                             width: 32,
//                             startTime: DateTime.now().add(Duration(minutes: 195)),
//                             endTime: DateTime.now().add(Duration(minutes: 227)),
//                             duration: 32,
//                           ),
//                           SleepDetailChart(
//                             model: SleepStage.deep,
//                             width: 33,
//                             startTime: DateTime.now().add(Duration(minutes: 227)),
//                             endTime: DateTime.now().add(Duration(minutes: 260)),
//                             duration: 33,
//                           ),
//                         ],
//                         stageColors: stageColors,
//                         sleepStageStyles: [
//                           SleepStageStyle(
//                             gradientColor: [Color(0xFF4870F3), Color(0xFF21B2A1)],
//                             value: SleepStageStyleValue.deepAndLight,
//                           ),
//                           SleepStageStyle(
//                             gradientColor: [Color(0xFFFCD166), Color(0xFF21B2A1)],
//                             value: SleepStageStyleValue.deepAndRem,
//                           ),
//                           SleepStageStyle(
//                             gradientColor: [Color(0xFFFCD169), Color(0xFF4870F3)],
//                             value: SleepStageStyleValue.lightAndRem,
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     Spacer(),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 top: 20,
//                 right: 20,
//                 child: Container(
//                   padding: EdgeInsets.all(0),
//                   alignment: Alignment.center,
//                   width: 110,
//                   // height: 100,
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.primary.withAlpha(50),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     spacing: 0,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     // crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("80%",style: TextStyle(fontSize: 40),),
//                       Text("Sleep Score"),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 20,
//                 left: 20,
//                 child: Container(
//                   alignment: Alignment.center,
//                   width: 110,
//                   // height: 100,
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.primary.withAlpha(50),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       // crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("87",style: TextStyle(fontSize: 50),),
//                         Column(
//
//                           children: [
//                             Icon(Icons.heart_broken_outlined,color: Colors.red,),
//                             Text("bpm"),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//
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
//             BoxShadow(
//                 blurRadius: 20,
//                 offset: Offset(0, 0),
//                 color: Theme.of(context).colorScheme.primary),
//             BoxShadow(
//                 blurRadius: 20,
//                 offset: Offset(0, 0),
//                 color: Theme.of(context).colorScheme.primaryContainer),
//           ]
//         ),
//         width: 200,
//         height: 100,
//         child: FloatingActionButton(
//           foregroundColor: Theme.of(context).colorScheme.inversePrimary,
//           backgroundColor: Colors.transparent,
//
//
//           onPressed: () {
//             Navigator.push(
//               context,
//               PageRouteBuilder(
//                 transitionDuration: Duration(milliseconds: 1200),
//                 reverseTransitionDuration: Duration(milliseconds: 1200),
//                 pageBuilder: (_, __, ___) => ChatBotScreen(),
//               ),
//             );
//           },
//           child: Text("Start Sleep",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
//         ),
//       ),
//     );
//   }
// }
