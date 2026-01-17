import 'package:equatable/equatable.dart';

abstract class ChatbotEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatbotStartRequested extends ChatbotEvent {}

class ChatbotSubmitAnswer extends ChatbotEvent {
  final String nodeId;
  final dynamic answerValue;
  final String answerLabel;
  ChatbotSubmitAnswer({required this.nodeId, required this.answerValue, required this.answerLabel});
  @override
  List<Object?> get props => [nodeId, answerValue, answerLabel];
}

class ChatbotRestartRequested extends ChatbotEvent {}