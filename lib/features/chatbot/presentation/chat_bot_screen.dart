// // // import 'package:flutter/material.dart';
// // // import 'package:sleep_chart/sleep_chart.dart';
// // //
// // // class ChatBotScreen extends StatefulWidget {
// // //   const ChatBotScreen({super.key});
// // //
// // //   @override
// // //   State<ChatBotScreen> createState() => _ChatBotScreenState();
// // // }
// // //
// // // class _ChatBotScreenState extends State<ChatBotScreen> {
// // //   late Map<SleepStage, Color> stageColors = {
// // //     SleepStage.light: Theme.of(context).colorScheme.primary,
// // //     SleepStage.deep: Theme.of(context).colorScheme.inversePrimary,
// // //     SleepStage.rem: Theme.of(context).colorScheme.inverseSurface,
// // //   };
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.transparent,
// // //       body: SafeArea(
// // //         child: Container(
// // //           decoration: BoxDecoration(
// // //             image: DecorationImage(
// // //               colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
// // //               image: AssetImage("assets/images/bg_plain.jpg"),
// // //               fit: BoxFit.cover,
// // //             ),
// // //           ),
// // //
// // //           // 🔥 NEW LAYOUT: Everything in a Stack
// // //           child: Stack(
// // //             children: [
// // //
// // //
// // //
// // //               // --------------------------------------------------
// // //               // 3️⃣ FULL MOON ABOVE MOUNTAINS
// // //               // --------------------------------------------------
// // //               Positioned(
// // //                 left: 0,
// // //                 right: 0,
// // //                 top: 150,
// // //                 child: Hero(
// // //                   tag: "fullMoon",
// // //                   child: Image.asset(
// // //                     "assets/svgs/full_moon.png",
// // //                     height: 180,
// // //                   ),
// // //                 ),
// // //               ),
// // //               // --------------------------------------------------
// // //               // 2️⃣ MOUNTAINS ALWAYS AT BOTTOM (never shrink)
// // //               // --------------------------------------------------
// // //               Positioned(
// // //                 left: 0,
// // //                 right: 0,
// // //                 bottom: 0,
// // //                 child: Hero(
// // //                   tag: "mountains",
// // //                   child: Image.asset(
// // //                     "assets/svgs/mountains.png",
// // //                     fit: BoxFit.cover,
// // //                   ),
// // //                 ),
// // //               ),
// // //               // --------------------------------------------------
// // //               // 1️⃣ FOREGROUND CONTENT (chart + spacing)
// // //               // --------------------------------------------------
// // //               Positioned(
// // //                 right: 10,
// // //                 left: 10,
// // //                 bottom: 50,
// // //                 child:
// // //                 TextField(
// // //                   decoration: InputDecoration(
// // //                     border: OutlineInputBorder(
// // //
// // //                         borderRadius: BorderRadius.circular(25),
// // //                       borderSide: BorderSide(
// // //                          style: BorderStyle.solid,
// // //                         color:Colors.red,
// // //                       )
// // //                     ),
// // //                   contentPadding: EdgeInsets.all(15),
// // //                   hintText: "Message",
// // //                   suffixIcon: Icon(Icons.mic),
// // //                   filled: true,
// // //                     fillColor: Theme.of(context).colorScheme.primary.withAlpha(80),
// // //                   ),
// // //
// // //                 ),
// // //                 // child: Column(
// // //                 //   crossAxisAlignment: CrossAxisAlignment.center,
// // //                 //   children: [
// // //                 //
// // //                 //
// // //                 //   ],
// // //                 // ),
// // //               ),
// // //
// // //
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //
// // //     );
// // //   }
// // // }
// //
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import '../../../core/injection.dart';
// // import '../domain/entities/chat_entites.dart';
// // import 'bloc/chatbot_bloc.dart';
// // import 'bloc/chatbot_event.dart';
// // import 'bloc/chatbot_state.dart';
// //
// // class ChatBotScreen extends StatelessWidget {
// //   const ChatBotScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider(
// //       create: (_) => sl<ChatbotBloc>()..add(ChatbotStartRequested()),
// //       child: const _ChatBotView(),
// //     );
// //   }
// // }
// //
// // class _ChatBotView extends StatelessWidget {
// //   const _ChatBotView();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.transparent,
// //       body: SafeArea(
// //         child: Container(
// //           decoration: const BoxDecoration(
// //             image: DecorationImage(
// //               image: AssetImage("assets/images/bg_plain.jpg"),
// //               fit: BoxFit.cover,
// //               colorFilter: ColorFilter.mode(
// //                 Colors.black54,
// //                 BlendMode.darken,
// //               ),
// //             ),
// //           ),
// //           child: Column(
// //             children: [
// //               Expanded(
// //                 child: BlocBuilder<ChatbotBloc, ChatbotState>(
// //                   builder: (context, state) {
// //                     if (state is ChatbotLoading ||
// //                         state is ChatbotInitial) {
// //                       return const Center(
// //                         child: CircularProgressIndicator(),
// //                       );
// //                     }
// //
// //                     if (state is ChatbotLoaded ||
// //                         state is ChatbotCompleted) {
// //                       final messages = state is ChatbotLoaded
// //                           ? state.messages
// //                           : (state as ChatbotCompleted).messages;
// //
// //                       final currentNode = state is ChatbotLoaded
// //                           ? state.currentNode
// //                           : null;
// //
// //                       return _ChatBody(
// //                         messages: messages,
// //                         currentNode: currentNode,
// //                       );
// //                     }
// //
// //                     if (state is ChatbotError) {
// //                       return Center(
// //                         child: Text(
// //                           state.message,
// //                           style: const TextStyle(color: Colors.black),
// //                         ),
// //                       );
// //                     }
// //
// //                     return const SizedBox();
// //                   },
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class _ChatBody extends StatelessWidget {
// //   final List<dynamic> messages;
// //   final ChatNodeEntity? currentNode;
// //
// //   const _ChatBody({
// //     required this.messages,
// //     required this.currentNode,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         Expanded(
// //           child: ListView.builder(
// //             padding: const EdgeInsets.all(16),
// //             itemCount: messages.length,
// //             itemBuilder: (_, index) {
// //               final msg = messages[index];
// //               return _MessageBubble(
// //                 text: msg['text']?.toString() ?? '',
// //                 type: msg['type']?.toString() ?? 'system',
// //               );
// //             },
// //           ),
// //         ),
// //
// //         if (currentNode != null &&
// //             currentNode!.answers.isNotEmpty)
// //           _AnswersBar(node: currentNode!),
// //       ],
// //     );
// //   }
// // }
// //
// // class _MessageBubble extends StatelessWidget {
// //   final String text;
// //   final String type;
// //
// //   const _MessageBubble({
// //     required this.text,
// //     required this.type,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final isAnswer = type == 'answer';
// //     final isQuestion = type == 'question';
// //     final isOutcome = type == 'outcome';
// //
// //     Color bg;
// //     Alignment align;
// //
// //     if (isAnswer) {
// //       bg = Theme.of(context).colorScheme.primary;
// //       align = Alignment.centerRight;
// //     } else if (isQuestion) {
// //       bg = Theme.of(context).colorScheme.surface;
// //       align = Alignment.centerLeft;
// //     } else {
// //       bg = Colors.grey.shade700;
// //       align = Alignment.center;
// //     }
// //
// //     return Align(
// //       alignment: align,
// //       child: Container(
// //         margin: const EdgeInsets.symmetric(vertical: 6),
// //         padding: const EdgeInsets.all(14),
// //         constraints: const BoxConstraints(maxWidth: 300),
// //         decoration: BoxDecoration(
// //           color: bg,
// //           borderRadius: BorderRadius.circular(16),
// //         ),
// //         child: Text(
// //           text,
// //           style: TextStyle(
// //             color: isOutcome?Colors.black:isAnswer ? Colors.white : Theme.of(context).colorScheme.primary,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class _AnswersBar extends StatelessWidget {
// //   final ChatNodeEntity node;
// //
// //   const _AnswersBar({required this.node});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
// //       child: Wrap(
// //         spacing: 8,
// //         runSpacing: 8,
// //         children: node.answers.map((a) {
// //           return ElevatedButton(
// //             onPressed: () {
// //               context.read<ChatbotBloc>().add(
// //                 ChatbotSubmitAnswer(
// //                   nodeId: node.id,
// //                   answerValue: a.value,
// //                   answerLabel: a.label,
// //                 ),
// //               );
// //             },
// //             child: Text(a.label),
// //           );
// //         }).toList(),
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../domain/entities/chat_entites.dart';
// import 'bloc/chatbot_bloc.dart';
// import 'bloc/chatbot_event.dart';
// import 'bloc/chatbot_state.dart';
//
// class ChatBotScreen extends StatefulWidget {
//   const ChatBotScreen({super.key});
//
//   @override
//   State<ChatBotScreen> createState() => _ChatBotScreenState();
// }
//
// class _ChatBotScreenState extends State<ChatBotScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//
//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // Start chatbot session
//     context.read<ChatbotBloc>().add(ChatbotStartRequested());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("SleepWell Chatbot")),
//       body: BlocBuilder<ChatbotBloc, ChatbotState>(
//         builder: (context, state) {
//           List<dynamic> messages = [];
//           ChatNodeEntity? currentNode;
//
//           if (state is ChatbotLoaded) {
//             messages = state.messages;
//             currentNode = state.currentNode;
//           } else if (state is ChatbotCompleted) {
//             messages = state.messages;
//             currentNode = null;
//           }
//
//           return Column(
//             children: [
//               // Chat messages
//               Expanded(
//                 child: ListView.builder(
//                   controller: _scrollController,
//                   padding: const EdgeInsets.all(12),
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     final msg = messages[index];
//                     final type = msg['type'] ?? 'system';
//                     final text = msg['text'] ?? '';
//
//                     switch (type) {
//                       case 'question':
//                         return _buildMessageBubble(text, isQuestion: true);
//                       case 'answer':
//                         return _buildMessageBubble(text, isAnswer: true);
//                       case 'system':
//                         if (text.startsWith('Outcome:')) {
//                           return _buildOutcomeCard(msg);
//                         }
//                         return _buildMessageBubble(text, isSystem: true);
//                       default:
//                         return _buildMessageBubble(text, isSystem: true);
//                     }
//                   },
//                 ),
//               ),
//
//               // Input area (if session not completed)
//               if (state is ChatbotLoaded && currentNode != null)
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Wrap(
//                     spacing: 8,
//                     children: currentNode.answers.map((a) {
//                       return ElevatedButton(
//                         onPressed: () {
//                           context.read<ChatbotBloc>().add(ChatbotSubmitAnswer(
//                             nodeId: currentNode!.id,
//                             answerValue: a.value,
//                             answerLabel: a.label,
//                           ));
//                           _controller.clear();
//                           _scrollToBottom();
//                         },
//                         child: Text(a.label),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//
//               // Loading indicator
//               if (state is ChatbotLoading)
//                 const Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: CircularProgressIndicator(),
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//
//
//   Widget _buildMessageBubble(
//       String text, {
//         bool isQuestion = false,
//         bool isAnswer = false,
//         bool isSystem = false,
//       }) {
//     Color bgColor;
//     Alignment alignment;
//
//     if (isQuestion) {
//       bgColor = Theme.of(context).colorScheme.secondaryContainer;
//       alignment = Alignment.centerLeft;
//     } else if (isAnswer) {
//       bgColor = Theme.of(context).colorScheme.primary;
//       alignment = Alignment.centerRight;
//     } else {
//       // system or default
//       bgColor = Colors.grey.shade300;
//       alignment = Alignment.center;
//     }
//
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 4),
//       alignment: alignment,
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: bgColor,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Text(text, style: isSystem?TextStyle(color: Colors.black):TextStyle(color: Colors.white)),
//       ),
//     );
//   }
//
//
//   Widget _buildOutcomeCard(Map<String, dynamic> msg) {
//     final text = msg['text'] ?? 'Outcome';
//     // Try to parse actions if present
//     final actionsText = msg['actions'] != null ? msg['actions'].toString() : null;
//
//     return Card(
//       color: Colors.orange.shade100,
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: const [
//                 Icon(Icons.emoji_events, color: Colors.orange),
//                 SizedBox(width: 8),
//                 Text('Outcome', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Text(text, style: const TextStyle(fontSize: 16,color: Colors.black)),
//             if (actionsText != null) ...[
//               const SizedBox(height: 8),
//               Text('Actions: $actionsText', style: const TextStyle(color: Colors.black87)),
//             ]
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../domain/entities/chat_entites.dart';
import 'bloc/chatbot_bloc.dart';
import 'bloc/chatbot_event.dart';
import 'bloc/chatbot_state.dart';
import '../../../core/injection.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Start chatbot session
    context.read<ChatbotBloc>().add(ChatbotStartRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SleepWell Chatbot")),
      body: BlocBuilder<ChatbotBloc, ChatbotState>(
        builder: (context, state) {
          List<dynamic> messages = [];
          ChatNodeEntity? currentNode;

          if (state is ChatbotLoaded) {
            messages = state.messages;
            currentNode = state.currentNode;
          } else if (state is ChatbotCompleted) {
            messages = state.messages;
            currentNode = null;
          }

          return Column(
            children: [
              // Chat messages
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(12),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final type = msg['type'] ?? 'system';
                    final text = msg['text'] ?? '';
                    // Logger().w("${msg}");
                    // Check for outcome first
                    // if (msg['next'] != null && msg['next']['type'] == 'outcome') {
                    //   final outcome = msg['next']['outcome'] as Map<String, dynamic>? ?? {};
                    //   final title = outcome['title'] ?? outcome['code'] ?? 'Outcome';
                    //   final actions = outcome['actions'] as Map<String, dynamic>? ?? {};
                    //   return _buildOutcomeCard(title, actions);
                    // }
                    if (type == 'outcome') {
                      final actions = msg['actions'] as Map<String, dynamic>? ?? {};
                      return _buildOutcomeCard(msg['text'], actions);
                    }

                    // Regular messages
                    switch (type) {
                      case 'question':
                        return _buildMessageBubble(text, isQuestion: true);
                      case 'answer':
                        return _buildMessageBubble(text, isAnswer: true);
                      case 'system':
                      default:
                        return _buildMessageBubble(text, isSystem: true);
                    }
                  },
                ),
              ),

              // Input area (if session not completed)
              if (state is ChatbotLoaded && currentNode != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Wrap(
                    spacing: 50,
                    children: currentNode.answers.map((a) {
                      return ElevatedButton(
                        style: ButtonStyle(
                          elevation: WidgetStatePropertyAll(10),
                          backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
                          foregroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.onPrimary),
                        ),
                        onPressed: () {
                          context.read<ChatbotBloc>().add(ChatbotSubmitAnswer(
                            nodeId: currentNode!.id,
                            answerValue: a.value,
                            answerLabel: a.label,
                          ));
                          _controller.clear();
                          _scrollToBottom();
                        },
                        child: Text(a.label,style: TextStyle(fontSize: 20),),
                      );
                    }).toList(),
                  ),
                ),

              // Loading indicator
              if (state is ChatbotLoading)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMessageBubble(
      String text, {
        bool isQuestion = false,
        bool isAnswer = false,
        bool isSystem = false,
      }) {
    Color bgColor;
    Alignment alignment;

    if (isQuestion) {
      bgColor = Theme.of(context).colorScheme.secondaryContainer;
      alignment = Alignment.centerLeft;
    } else if (isAnswer) {
      bgColor = Theme.of(context).colorScheme.primary;
      alignment = Alignment.centerRight;
    } else {
      // system or default
      bgColor = Colors.grey.shade300;
      alignment = Alignment.center;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      alignment: alignment,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: isSystem
              ? const TextStyle(color: Colors.black)
              : const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildOutcomeCard(String title, Map<String, dynamic> actions) {
    return Card(
      color: Theme.of(context).colorScheme.primaryFixedDim,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.emoji_events, color: Colors.orange),
                SizedBox(width: 8),
                Text('Outcome', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
              ],
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 12),
            if (actions.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (actions['trigger_music'] == true)
                    Text('🎵 Music: ${actions['music_type'] ?? 'default'}',style: TextStyle( color: Colors.black),),
                  if (actions['trigger_face_capture'] == true)
                    const Text('📸 Face capture enabled',style: TextStyle( color: Colors.black),),
                  if (actions['breathing_exercise'] != null && actions['breathing_exercise'] != 'none')
                    Text('💨 Breathing exercise: ${actions['breathing_exercise']}',style: TextStyle( color: Colors.black),),
                  if (actions['journaling'] != null && actions['journaling'] != 'none')
                    Text('📓 Journaling: ${actions['journaling']}',style: TextStyle( color: Colors.black),),
                  if (actions['sleep_mode'] == true)
                    const Text('🛌 Sleep mode: ON',style: TextStyle( color: Colors.black),),
                  if (actions['task_advice'] != null && actions['task_advice'] != '')
                    Text('📝 Task advice: ${actions['task_advice']}',style: TextStyle( color: Colors.black),),
                  if (actions['screen_hygiene'] == true)
                    const Text('📱 Screen hygiene enabled',style: TextStyle( color: Colors.black),),
                  if (actions['note'] != null && actions['note'] != '')
                    Text('🗒 Note: ${actions['note']}',style: TextStyle( color: Colors.black),),
                ],
              ),
          ],
        ),
      ),
    );
  }

}
