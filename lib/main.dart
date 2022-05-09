import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/calculation_bloc.dart';
import 'buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculationBloc(),
      child: const MaterialApp(
        title: 'Calculator Bloc',
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: MyCalc()),
      ),
    );
  }
}

class MyCalc extends StatefulWidget {
  const MyCalc({Key? key}) : super(key: key);

  @override
  _MyCalcState createState() => _MyCalcState();
}

class _MyCalcState extends State<MyCalc> {
  _onButtonTap(Button button) {
    switch (button.type) {
      case ButtonType.operation:
        context
            .read<CalculationBloc>()
            .add(OperationPressed(operation: button.character));
        break;
      case ButtonType.number:
        context
            .read<CalculationBloc>()
            .add(NumberPressed(number: button.value));
        break;
      case ButtonType.result:
        context.read<CalculationBloc>().add(CalculateResult());
        break;
      case ButtonType.clear:
        context.read<CalculationBloc>().add(ClearCalculation());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).highlightColor,
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.only(right: 30.0, bottom: 10),
            height: 200,
            child: BlocBuilder<CalculationBloc, CalculationState>(
              builder: (context, state) {
                return Text(
                  state.currentValue.toString(),
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GridView.count(
                  crossAxisCount: 4,
                  childAspectRatio:
                      constraints.maxWidth / constraints.maxHeight,
                  children: buttonList.map(
                    (button) {
                      return BlocBuilder<CalculationBloc, CalculationState>(
                        buildWhen: ((previous, current) {
                          return previous.operation == button.character ||
                              current.operation == button.character;
                        }),
                        builder: (context, state) {
                          return Container(
                            color: state.operation == button.character &&
                                    state.valueEditable == false
                                ? Theme.of(context).highlightColor
                                : Colors.transparent,
                            child: TextButton(
                              onPressed: () => _onButtonTap(button),
                              child: Text(
                                button.character,
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ).toList(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
