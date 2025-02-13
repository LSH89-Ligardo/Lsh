void main() {
  // 조건이 충족 되었는지 확인하기
  bool isFootball = true;

  // if-else statement: 조건이 참이면 if 블록 실행, 거짓이면 else 블록 실행
  if (isFootball) {
    print('Go football');
    // ignore: dead_code
  } else {
    print('Go Sports!');
  }

  bool isTrue = true;

  // while loop: 조건이 참일 때 실행
  while (isTrue) {
    print('Hello');
    isTrue = false;
  }

  // do-while loop: 조건이 참이든 거짓이든 한 번은 실행
  do {
    print('Hello 2');
  } while (isTrue);

  // switch statement: 다양한 조건을 비교할 때 사용
  int myValue = 2;

  switch (myValue) {
    case 1:
      print('Monday');
    case 2:
      print('Tuesday');
    default:
      print('Error: Value not defined?');
  }

  // 슬래시, 별, 쉼표, 세미콜론 등이 상수 변수인 경우...

  String charCode = '1';

  switch (charCode) {
    case '/' || '*' || '+' || '-':
      print('Mathematical operator');
    default:
      print('Unknown');
  }

  int numValue = 5;

  switch (numValue) {
    // 0부터 9까지의 숫자인 경우, 비교 연산자와 논리 연산자를 사용할 수 있음
    case >= 0 && <= 9:
      print('Single digit number');
    default:
      print('Unknown');
  }

  // switch statement with return
  print(smallSwitchReturn(1));

  // for loop: 반복 횟수가 정해진 경우 사용
  int maxIterations = 5;
  for (var i = 0; i < maxIterations; i++) {
    print('Iteration: $i');
  }

  // forEach loop: 배열, 리스트, 맵 등의 요소를 반복할 때 사용
  List daysOfWeek = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  // 기본 함수 사용
  daysOfWeek.forEach((day) {
    print(day);
  });

  // forEach loop with arrow function: 람다 함수를 사용하여 간단하게 표현
  daysOfWeek.forEach((day) => print(day));

  // forEach loop with function reference: 함수 참조를 사용하여 간단하게 표현
  daysOfWeek.forEach(print);

  print(Day.values);
  print('${Day.values[0]}');
  print(Day.values.byName('mon'));

  // Error handling
  String name = 'Dart';

  try {
    print('Name: $name');
    // indexOf() 함수는 문자열에서 특정 문자의 인덱스를 반환,
    // 첫번째 파라미터 name[0]은 문자열의 첫 번째 문자를 의미
    // 두번째 파라미터 name.length - (name.length +2) 는 인덱스 범위
    name.indexOf(name[0], name.length - (name.length + 2));
  } on RangeError catch (exception) {
    print('On Exception: $exception');
  } catch (exception) {
    print('Catch Exception: $exception');
  } finally {
    print('Mission completed!');
  }
}

// 열거형 사용하기
enum Day { sun, mon, tues }

String smallSwitchReturn(int intValue) {
  return switch (intValue) {
    1 => "value is 1",
    2 => "value is 2",
    _ => "another value"
  };
}
