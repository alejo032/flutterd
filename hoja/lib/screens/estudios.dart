import 'package:flutter/material.dart';

class estudios extends StatefulWidget {
  const estudios({super.key});

  @override
  State<estudios> createState() => _estudiosState();
}

class _estudiosState extends State<estudios> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text("Estudios",style: TextStyle(color: Colors.white, fontSize: 50),),
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
                'Estudié en la Universidad de Horizon, donde me gradué con honores en Ingeniería Biomédica. Durante mi carrera, realicé investigaciones pioneras en la interfaz de prótesis neurales, explorando nuevas formas de mejorar la comunicación entre el cerebro y las extremidades artificiales. Recibí reconocimientos por mi trabajo en conferencias internacionales, así como una beca de investigación para continuar mis estudios de posgrado en neurociencia aplicada. Además, participé activamente en proyectos de servicio comunitario, donde apliqué mis conocimientos para diseñar dispositivos médicos asequibles para comunidades marginadas. Estos logros fueron fundamentales para mi desarrollo profesional y mi pasión por mejorar la calidad de vida a través de la tecnología.'),
          )),
        ],
      ),
    );
  }
}