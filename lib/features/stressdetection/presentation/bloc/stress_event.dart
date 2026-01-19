import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class StressEvent extends Equatable {
  const StressEvent();

  @override
  List<Object?> get props => [];
}

class DetectStressFromImage extends StressEvent {
  final File image;
  final DateTime? date;

  const DetectStressFromImage({
    required this.image,
    this.date,
  });

  @override
  List<Object?> get props => [image, date];
}
