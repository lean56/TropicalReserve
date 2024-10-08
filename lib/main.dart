import 'package:flutter/material.dart';
import 'package:myapp/pages/navegacion_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tropical Reserve',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NavigationMenu(),
    );
  }
}
