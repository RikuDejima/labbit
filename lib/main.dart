import 'package:flutter/material.dart';
import 'package:labbit/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MaterialColor customSwatch = const MaterialColor(
    0xfffff7cb,
    const <int, Color>{
      50: const Color(0xfffffef9),
      100: const Color(0xfffffdef),
      200: const Color(0xfffffbe5),
      300: const Color(0xfffff9db),
      400: const Color(0xfffff8d3),
      500: const Color(0xfffff7cb),
      600: const Color(0xfffff6c6),
      700: const Color(0xfffff5be),
      800: const Color(0xfffff3b8),
      900: const Color(0xfffff1ac),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
