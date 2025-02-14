import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// 앱의 메인 위젯
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // 처음 보여줄 화면
    );
  }
}

// 로고 화면
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ToDo List',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // "시작하기" 버튼 클릭 시 설명 화면으로 이동
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => DescriptionScreen()),
                );
              },
              child: Text('시작하기'),
            ),
          ],
        ),
      ),
    );
  }
}

// 설명 화면
class DescriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '할 일 관리 앱',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              '이 앱을 사용하여 일정을 관리하고, 할 일을 체계적으로 정리하세요.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // "로그인하기" 버튼 클릭 시 로그인 화면으로 이동
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('로그인하기'),
            ),
          ],
        ),
      ),
    );
  }
}

// 로그인 화면
class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('로그인')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: '사용자 이름'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: '비밀번호'),
              obscureText: true, // 비밀번호는 숨김 처리
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 로그인 버튼 클릭 시 입력값 검증
                if (usernameController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  // 입력값이 유효하면 메인 화면으로 이동
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                } else {
                  // 입력값이 없으면 경고 메시지 표시
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('사용자 이름과 비밀번호를 입력하세요.')),
                  );
                }
              },
              child: Text('로그인'),
            ),
          ],
        ),
      ),
    );
  }
}

// 메인 화면
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController todoController = TextEditingController();
  final List<String> todoList = []; // 할 일 목록

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('할 일 목록')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: todoController,
              decoration: InputDecoration(labelText: '할 일을 입력하세요'),
            ),
            ElevatedButton(
              onPressed: () {
                // 추가하기 버튼 클릭 시 할 일 추가
                if (todoController.text.isNotEmpty) {
                  setState(() {
                    // 할 일 목록에 추가하고 입력창 비우기
                    todoList.add(todoController.text);
                    todoController.clear();
                  });
                } else {
                  // 입력값이 없으면 경고 메시지 표시
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('할 일을 입력하세요.')),
                  );
                }
              },
              child: Text('추가하기'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todoList.length, // 할 일 목록의 길이
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(todoList[index]), // 할 일 목록의 각 항목 표시
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
