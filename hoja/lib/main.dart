import 'package:flutter/material.dart';
import 'package:hoja/screens/menu_sreen.dart';

void main() {
  runApp(const MainApp()); //ejecutar la clase principal
}

// nos permite crear los screen para la app
//staless: estatico - staful
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: Text('Mi app', style: TextStyle(color: Colors.red))
      home: MenuScreen(),
    );
  }
}
