import 'package:equatable/equatable.dart';

class CalculationState extends Equatable {
  const CalculationState({
    this.previousValue,
    this.operation,
    required this.currentValue,
    this.valueEditable,
  });

  final double? previousValue;
  final String? operation;
  final double currentValue;
  final bool? valueEditable;

  CalculationState copyWith({
    double? previousValue,
    String? operation,
    double? currentValue,
    bool? valueEditable,
  }) {
    return CalculationState(
      previousValue: previousValue ?? this.previousValue,
      operation: operation ?? this.operation,
      currentValue: currentValue ?? this.currentValue,
      valueEditable: valueEditable ?? this.valueEditable,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        previousValue,
        operation,
        currentValue,
        valueEditable,
      ];
}
