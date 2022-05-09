import 'package:flutter_bloc/flutter_bloc.dart';
import 'calculation_event.dart';
import 'calculation_state.dart';

export 'calculation_event.dart';
export 'calculation_state.dart';

class CalculationBloc extends Bloc<CalculationEvent, CalculationState> {
  CalculationBloc() : super(const CalculationState(currentValue: 0)) {
    EventHandler<CalculationEvent, CalculationState> buildHandler(
        dynamic asyncHandler) {
      return (event, emit) async => emit(await asyncHandler(event));
    }

    on<NumberPressed>(buildHandler(_onNumberPressed));
    on<OperationPressed>(buildHandler(_onOperationPressed));
    on<CalculateResult>(buildHandler(_onCalculateResult));
    on<ClearCalculation>(buildHandler(_onClearCalculation));
  }

  CalculationState _onNumberPressed(NumberPressed event) {
    if (state.valueEditable == false) {
      return state.copyWith(currentValue: event.number, valueEditable: true);
    } else {
      return state.copyWith(
          currentValue: state.currentValue * 10 + event.number);
    }
  }

  CalculationState _onOperationPressed(OperationPressed event) {
    CalculationState newState = state;
    if (state.operation != null && state.valueEditable == true) {
      CalculationState oldState = _onCalculateResult(CalculateResult());
      newState = oldState;
    }
    return newState.copyWith(
        previousValue: newState.currentValue,
        operation: event.operation,
        valueEditable: false);
  }

  CalculationState _onCalculateResult(CalculateResult event) {
    double result = state.currentValue;
    double? prevVal = state.previousValue;
    if (prevVal != null) {
      switch (state.operation) {
        case '+':
          result = prevVal + state.currentValue;
          break;
        case '-':
          result = prevVal - state.currentValue;
          break;
        case 'x':
          result = prevVal * state.currentValue;
          break;
        case '/':
          result = prevVal / state.currentValue;
          break;
      }
    }
    return CalculationState(currentValue: result, valueEditable: false);
  }

  CalculationState _onClearCalculation(ClearCalculation event) {
    return const CalculationState(currentValue: 0);
  }
}
