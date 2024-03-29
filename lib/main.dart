import 'package:flutter/material.dart';
import 'package:flutter_code_demo/todos_screen.dart';

import 'login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) => LoginPage(),
        '/home': (BuildContext context) => NetworkPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
