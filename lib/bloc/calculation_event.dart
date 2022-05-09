import 'package:equatable/equatable.dart';

abstract class CalculationEvent extends Equatable {
  const CalculationEvent();
  @override
  List<Object?> get props => [];
}

class NumberPressed extends CalculationEvent {
  final double number;

  const NumberPressed({required this.number});

  @override
  List<Object> get props => [number];
}

class OperationPressed extends CalculationEvent {
  final String operation;

  const OperationPressed({required this.operation});

  @override
  List<Object> get props => [operation];
}

class CalculateResult extends CalculationEvent {}

class ClearCalculation extends CalculationEvent {}
