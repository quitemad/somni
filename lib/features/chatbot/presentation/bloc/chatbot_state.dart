import 'package:equatable/equatable.dart';
import '../../domain/entities/chat_entites.dart';

abstract class ChatbotState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatbotInitial extends ChatbotState {}

class ChatbotLoading extends ChatbotState {}

class ChatbotLoaded extends ChatbotState {
  final String sessionId;
  final ChatNodeEntity? currentNode;
  final List<dynamic> messages; // you can replace dynamic with message entity
  ChatbotLoaded({required this.sessionId, required this.currentNode, required this.messages});
  @override
  List<Object?> get props => [sessionId, currentNode, messages];
}

class ChatbotCompleted extends ChatbotState {
  final List<dynamic> messages;
  ChatbotCompleted({required this.messages});
  @override
  List<Object?> get props => [messages];
}

class ChatbotError extends ChatbotState {
  final String message;
  ChatbotError(this.message);
  @override
  List<Object?> get props => [message];
}