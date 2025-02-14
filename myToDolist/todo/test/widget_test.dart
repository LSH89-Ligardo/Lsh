// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/main.dart';

void main() {
  testWidgets('ToDo List functionality test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // 시작 화면에서 "시작하기" 버튼을 찾고 클릭
    await tester.tap(find.text('시작하기'));
    await tester.pumpAndSettle(); // 모든 애니메이션을 완료하도록 대기

    // 설명 화면에서 "로그인하기" 버튼을 찾고 클릭
    await tester.tap(find.text('로그인하기'));
    await tester.pumpAndSettle();

    // 로그인 화면에서 사용자 이름과 비밀번호 입력
    await tester.enterText(find.byType(TextField).first, 'testuser');
    await tester.enterText(find.byType(TextField).last, 'password');

    // 로그인 버튼 클릭
    await tester.tap(find.text('로그인'));
    await tester.pumpAndSettle();

    // 메인 화면에서 할 일 추가 입력
    await tester.enterText(find.byType(TextField), '할 일 1');
    await tester.tap(find.text('추가하기'));
    await tester.pumpAndSettle();

    // 할 일이 목록에 추가되었는지 확인
    expect(find.text('할 일 1'), findsOneWidget);
  });
}
