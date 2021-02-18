import 'package:flutter/material.dart';
import 'package:labbit/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MaterialColor customSwatch = const MaterialColor(
    0xffFFF7CB,
    const <int, Color>{
      50: Color(0xFFFFFEF9),
      100: Color(0xFFFFFDEF),
      200: Color(0xFFFFFBE5),
      300: Color(0xFFFFF9DB),
      400: Color(0xFFFFF8D3),
      500: Color(0xffFFF7CB),
      600: Color(0xFFFFF6C6),
      700: Color(0xFFFFF5BE),
      800: Color(0xFFFFF3B8),
      900: Color(0xFFFFF1AC),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      home: MyHomePage(),
    );
  }
}
