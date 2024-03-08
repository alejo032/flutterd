import 'package:flutter/material.dart';
import 'package:gym_system/screens/menuscreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: Text('Mi app', style: TextStyle(color: Colors.red))
      home: MenuScreen(),
    );
  }
}
