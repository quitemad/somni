import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../../domain/entities/chat_entites.dart';
import '../../domain/usecases/start_session_usecase.dart';
import '../../domain/usecases/submit_answe_usecase.dart';
import 'chatbot_event.dart';
import 'chatbot_state.dart';

class ChatbotBloc extends Bloc<ChatbotEvent, ChatbotState> {
  final StartSessionUseCase startUseCase;
  final SubmitAnswerUseCase submitUseCase;

  ChatbotBloc({required this.startUseCase, required this.submitUseCase}) : super(ChatbotInitial()) {
    on<ChatbotStartRequested>(_onStart);
    on<ChatbotSubmitAnswer>(_onSubmit);
    on<ChatbotRestartRequested>((ev, emit) => add(ChatbotStartRequested()));
  }

  Future<void> _onStart(ChatbotStartRequested event, Emitter<ChatbotState> emit) async {
    emit(ChatbotLoading());
    try {
      final result = await startUseCase.call();
      final messages = <dynamic>[];
      if (result.node != null) {
        messages.add({'id': result.node!.id, 'text': result.node!.text, 'type': 'question'});
        emit(ChatbotLoaded(sessionId: result.sessionId ?? '', currentNode: result.node, messages: messages));
      } else {
        messages.add({'id': 'system', 'text': 'No question available', 'type': 'system'});
        emit(ChatbotCompleted(messages: messages));
      }
    } catch (e) {
      emit(ChatbotError(e.toString()));
    }
  }
  Future<void> _onSubmit(ChatbotSubmitAnswer event, Emitter<ChatbotState> emit) async {
    final s = state;
    if (s is! ChatbotLoaded) return;
    final current = s;

    // Add user answer
    final updatedMsgs = List<dynamic>.from(current.messages)
      ..add({
        'id': event.nodeId,
        'text': event.answerLabel,
        'type': 'answer'
      });

    emit(ChatbotLoaded(
      sessionId: current.sessionId,
      currentNode: current.currentNode,
      messages: updatedMsgs,
    ));

    try {
      final raw = await submitUseCase.call(
        sessionId: current.sessionId,
        nodeId: event.nodeId,
        answer: event.answerValue,
      );

      final next = raw['next'] as Map<String, dynamic>?;
      Logger().e("$next");

      if (next == null) {
        updatedMsgs.add({'id': 'system', 'text': 'No next node returned', 'type': 'system'});
        emit(ChatbotCompleted(messages: updatedMsgs));
        return;
      }

      final nextType = (next['type'] ?? '').toString();

      if (nextType == 'node' || nextType == 'question') {
        // normal question node
        final nodeRaw = (next['node'] ?? next) as Map<String, dynamic>;
        final node = ChatNodeEntity(
          id: nodeRaw['id']?.toString() ?? '',
          type: nodeRaw['type']?.toString() ?? 'question',
          text: nodeRaw['text']?.toString() ?? '',
          answers: (nodeRaw['answers'] as List<dynamic>? ?? [])
              .map((a) => ChatAnswerEntity(value: a['value'].toString(), label: a['label'].toString()))
              .toList(),
        );
        updatedMsgs.add({'id': node.id, 'text': node.text, 'type': 'question'});
        emit(ChatbotLoaded(sessionId: current.sessionId, currentNode: node, messages: updatedMsgs));
      } else if (nextType == 'outcome') {
        // --- NEW OUTCOME HANDLING ---
        final outcome = next['outcome'] ?? {};
        final code = outcome['code'] ?? '';
        final title = outcome['title'] ?? '';
        final actions = outcome['actions'] ?? {};

        // updatedMsgs.add({'id': 'system', 'text': 'Outcome: $title ($code)', 'type': 'system'});
        // updatedMsgs.add({'id': 'system', 'text': 'Actions: ${actions.toString()}', 'type': 'system'});
        updatedMsgs.add({
          'id': 'system',
          'type': 'outcome', // mark it as outcome
          'text': '$title ($code)',
          'actions': actions, // keep it as Map
        });

        // If there is a post_outcome_question, continue
        final postNodeRaw = raw['post_outcome_question'] as Map<String, dynamic>?;
        if (postNodeRaw != null) {
          final node = ChatNodeEntity(
            id: postNodeRaw['id']?.toString() ?? '',
            type: postNodeRaw['type']?.toString() ?? 'question',
            text: postNodeRaw['text']?.toString() ?? '',
            answers: (postNodeRaw['answers'] as List<dynamic>? ?? [])
                .map((a) => ChatAnswerEntity(value: a['value'].toString(), label: a['label'].toString()))
                .toList(),
          );
          updatedMsgs.add({'id': node.id, 'text': node.text, 'type': 'question'});
          emit(ChatbotLoaded(sessionId: current.sessionId, currentNode: node, messages: updatedMsgs));
        } else {
          emit(ChatbotCompleted(messages: updatedMsgs));
        }
      } else {
        updatedMsgs.add({'id': 'system', 'text': 'Next: ${next.toString()}', 'type': 'system'});
        emit(ChatbotCompleted(messages: updatedMsgs));
      }
    } catch (e) {
      final err = List<dynamic>.from(updatedMsgs)
        ..add({'id': 'system', 'text': 'Failed to submit answer: $e', 'type': 'system'});
      emit(ChatbotError('Failed to submit answer: $e'));
      emit(ChatbotCompleted(messages: err));
    }
  }

  // Future<void> _onSubmit(ChatbotSubmitAnswer event, Emitter<ChatbotState> emit) async {
  //   final s = state;
  //   if (s is! ChatbotLoaded) return;
  //   final current = s;
  //   final updatedMsgs = List<dynamic>.from(current.messages)
  //     ..add({'id': event.nodeId, 'text': event.answerLabel, 'type': 'answer'});
  //
  //   emit(ChatbotLoaded(sessionId: current.sessionId, currentNode: current.currentNode, messages: updatedMsgs));
  //
  //   try {
  //     final raw = await submitUseCase.call(sessionId: current.sessionId, nodeId: event.nodeId, answer: event.answerValue);
  //     final next = raw['next'] as Map<String, dynamic>?;
  //     if (next == null) {
  //       updatedMsgs.add({'id': 'system', 'text': 'No next node returned', 'type': 'system'});
  //       emit(ChatbotCompleted(messages: updatedMsgs));
  //       return;
  //     }
  //
  //     final nextType = (next['type'] ?? '').toString();
  //     if (nextType == 'node' || nextType == 'question') {
  //       final nodeRaw = (next['node'] ?? next) as Map<String, dynamic>;
  //       final node = ChatNodeEntity(
  //         id: nodeRaw['id']?.toString() ?? '',
  //         type: nodeRaw['type']?.toString() ?? 'question',
  //         text: nodeRaw['text']?.toString() ?? '',
  //         answers: (nodeRaw['answers'] as List<dynamic>? ?? []).map((a) => ChatAnswerEntity(value: a['value'].toString(), label: a['label'].toString())).toList(),
  //       );
  //       updatedMsgs.add({'id': node.id, 'text': node.text, 'type': 'question'});
  //       emit(ChatbotLoaded(sessionId: current.sessionId, currentNode: node, messages: updatedMsgs));
  //     } else if (nextType == 'outcome') {
  //       updatedMsgs.add({'id': 'system', 'text': 'Outcome: ${next['outcome_code']}', 'type': 'system'});
  //       final actions = next['actions'] as List<dynamic>? ?? [];
  //       for (final a in actions) {
  //         final t = a is Map && a['type'] != null ? '${a['type']}${a['duration'] != null ? " (${a['duration']}m)" : ""}' : a.toString();
  //         updatedMsgs.add({'id': 'action-${a.hashCode}', 'text': 'Action: $t', 'type': 'system'});
  //       }
  //       emit(ChatbotCompleted(messages: updatedMsgs));
  //     } else {
  //       updatedMsgs.add({'id': 'system', 'text': 'Next: ${next.toString()}', 'type': 'system'});
  //       emit(ChatbotCompleted(messages: updatedMsgs));
  //     }
  //   } catch (e) {
  //     final err = List<dynamic>.from(updatedMsgs)..add({'id': 'system', 'text': 'Failed to submit answer: $e', 'type': 'system'});
  //     emit(ChatbotError('Failed to submit answer: $e'));
  //     emit(ChatbotCompleted(messages: err));
  //   }
  // }
}