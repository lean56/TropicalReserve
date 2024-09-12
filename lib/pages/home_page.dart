import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png', // Ruta de la imagen local
          width: 500,
          height: 500,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
