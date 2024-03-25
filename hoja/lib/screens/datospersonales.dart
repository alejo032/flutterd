import 'package:flutter/material.dart';

class datospersonales extends StatefulWidget {
  const datospersonales({super.key});

  @override
  State<datospersonales> createState() => _datospersonalesState();
}

class _datospersonalesState extends State<datospersonales> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text("Datos personales",style: TextStyle(color: Colors.white, fontSize: 50),),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView( // Para permitir el desplazamiento si el contenido es demasiado grande
        child: Column(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: Text(
                  'Nombre: Jaime Contreras\nEdad: 28 años\nLugar de residencia: Ciudad Metrópolis\nOcupación: Ingeniero de Software\nHabilidades: Dominio de varios lenguajes de programación, incluyendo Python, Java, JavaScript y C++. Experiencia en el desarrollo de aplicaciones web con Django y React, así como en el uso de TensorFlow para la inteligencia artificial. Habilidad para resolver problemas complejos y optimizar algoritmos. Experiencia en trabajo en equipo y comunicación efectiva en entornos interdisciplinarios. Intereses: Tecnología, inteligencia artificial, desarrollo de software, resolución de problemas, aprendizaje continuo. Personalidad: Proactivo, analítico, creativo, colaborador, orientado a resultados. Objetivos: Continuar creciendo profesionalmente en el campo de la informática, contribuir al desarrollo de soluciones innovadoras y aplicar mis habilidades para resolver desafíos tecnológicos.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: Image.asset('assets/REIMU.JPG'), 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
