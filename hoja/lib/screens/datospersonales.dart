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
      body: Column(
        children: [
          Center(
              child: Container(
            
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            //height: 300.0,
            //width: 300.0,
            child: const Text(
                'Nombre: Jaime Contreras Edad: 28 años Lugar de residencia: Ciudad Metrópolis Ocupación: Ingeniero de Software Habilidades: Dominio de varios lenguajes de programación, incluyendo Python, Java, JavaScript y C++. Experiencia en el desarrollo de aplicaciones web con Django y React, así como en el uso de TensorFlow para la inteligencia artificial. Habilidad para resolver problemas complejos y optimizar algoritmos. Experiencia en trabajo en equipo y comunicación efectiva en entornos interdisciplinarios. Intereses: Tecnología, inteligencia artificial, desarrollo de software, resolución de problemas, aprendizaje continuo. Personalidad: Proactivo, analítico, creativo, colaborador, orientado a resultados. Objetivos: Continuar creciendo profesionalmente en el campo de la informática, contribuir al desarrollo de soluciones innovadoras y aplicar mis habilidades para resolver desafíos tecnológicos.'),
          )),
        ],
      ),
    );
  }
}