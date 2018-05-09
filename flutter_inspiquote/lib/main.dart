import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'InspiQuote',
      theme: new ThemeData(
        primaryColor: const Color(0xFF2195f2),
        accentColor: const Color(0xFF6ec6ff),
        primaryColorBrightness: Brightness.dark,
      ),
      home: new HomePage(),
    );
  }
}