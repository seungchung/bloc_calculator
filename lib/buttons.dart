enum ButtonType {
  number,
  operation,
  clear,
  result,
}

class Button {
  final ButtonType type;
  final String character;
  late final double value;

  Button({required this.type, required this.character}) {
    type == ButtonType.number ? value = double.parse(character) : value = 0;
  }
}

final List buttonList = [
  Button(type: ButtonType.number, character: '7'),
  Button(type: ButtonType.number, character: '8'),
  Button(type: ButtonType.number, character: '9'),
  Button(type: ButtonType.operation, character: 'x'),
  Button(type: ButtonType.number, character: '4'),
  Button(type: ButtonType.number, character: '5'),
  Button(type: ButtonType.number, character: '6'),
  Button(type: ButtonType.operation, character: '/'),
  Button(type: ButtonType.number, character: '1'),
  Button(type: ButtonType.number, character: '2'),
  Button(type: ButtonType.number, character: '3'),
  Button(type: ButtonType.operation, character: '+'),
  Button(type: ButtonType.clear, character: 'AC'),
  Button(type: ButtonType.number, character: '0'),
  Button(type: ButtonType.result, character: '='),
  Button(type: ButtonType.operation, character: '-'),
];
