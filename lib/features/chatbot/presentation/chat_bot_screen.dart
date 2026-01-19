import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/entities/chat_entites.dart';
import 'bloc/chatbot_bloc.dart';
import 'bloc/chatbot_event.dart';
import 'bloc/chatbot_state.dart';

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
      backgroundColor: Colors.transparent,
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
