import 'dart:math';

void main() {
  // List
  List<int> numbers = [1, 2, 3, 4, 5];

  // reduce: 리스트의 모든 요소를 하나의 값으로 합침
  print('Sum: ${numbers.reduce((value, element) => value + element)}');

  // Map
  Map<String, String> capitals = {
    'USA': 'Washington D.C.',
    'Korea': 'Seoul',
    'Japan': 'Tokyo'
  };

  print('Capital of USA: ${capitals['USA']}');

  // DataTime
  DateTime now = DateTime.now();
  print('Now: $now');

  // Math
  print('PI: ${pi}');
  print('Square root of 25: ${sqrt(25)}');
}
