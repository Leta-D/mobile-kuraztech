import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/pages/todo_Login.dart';
import 'package:task_manager/pages/todo_home.dart';
import 'pages/todo_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProviderAuthen()),
        ChangeNotifierProvider(create: (_) => TodoTaskProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoLoginPage(),
      routes: {
        "home": (context) => TodoHomePage(),
        "login": (context) => TodoLoginPage(),
      },
      initialRoute: "login",
    );
  }
}
