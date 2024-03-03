import 'package:app_votacion/screens/vota.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: Text('Contador de clicks'),
      home: votacion(), //LLAMAR OTRO SCREEN
    );
  }
}
