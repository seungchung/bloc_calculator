import 'package:meta/meta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:calculator_bloc/bloc/calculation_bloc.dart';

@isTest
void calculationTest(
    {required String description,
    required List<CalculationEvent> events,
    CalculationState? calculationState,
    int? skip}) {
  blocTest<CalculationBloc, CalculationState>(description,
      build: () => CalculationBloc(),
      act: (bloc) async {
        for (var event in events) {
          bloc.add(event);
          // Not sure why this is necessary for flutter_bloc >= 8.0.0.
          await Future.delayed(Duration.zero);
        }
        return bloc;
      },
      skip: skip ?? (events.length - 1),
      verify: (bloc) {
        calculationState?.currentValue != null
            ? expect(bloc.state.currentValue,
                wrapMatcher(calculationState?.currentValue))
            : null;
        calculationState?.operation != null
            ? expect(
                bloc.state.operation, wrapMatcher(calculationState?.operation))
            : null;
        calculationState?.previousValue != null
            ? expect(bloc.state.previousValue,
                wrapMatcher(calculationState?.previousValue))
            : null;
        calculationState?.valueEditable != null
            ? expect(bloc.state.valueEditable,
                wrapMatcher(calculationState?.valueEditable))
            : null;
      });
}

@isTest
void simplifiedTest(String eventsAsString,
    {int? skip,
    String? description,
    double? previousValue,
    String? operation,
    required double currentValue,
    bool? valueEditable}) {
  final events = eventsAsString.split('').map<CalculationEvent>((c) {
    try {
      return NumberPressed(number: double.parse(c));
      // ignore: empty_catches
    } catch (e) {}
    if (['+', '-', 'x', '/'].contains(c)) {
      return OperationPressed(operation: c);
    }
    if (c == 'c' || c == 'C') {
      return ClearCalculation();
    }
    if (c == '=') {
      return CalculateResult();
    }
    throw Exception('Invalid calculator bloc event.');
  }).toList();

  calculationTest(
      description: description ?? eventsAsString,
      events: events,
      calculationState: CalculationState(
          previousValue: previousValue,
          operation: operation,
          currentValue: currentValue,
          valueEditable: valueEditable),
      skip: skip);
}
