import 'package:flutter/material.dart';

class habilidades extends StatefulWidget {
  const habilidades({super.key});

  @override
  State<habilidades> createState() => _habilidadesState();
}

class _habilidadesState extends State<habilidades> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Habilidades",style: TextStyle(color: Colors.white, fontSize: 50),),
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
                'Poseo habilidades sólidas en varios lenguajes de programación, como Python, Java, JavaScript y C++. Además, tengo experiencia en el desarrollo de aplicaciones web con Django y React, así como en el uso de TensorFlow para la inteligencia artificial. Resuelvo problemas complejos y optimizo algoritmos con eficacia, y tengo experiencia trabajando en equipos interdisciplinarios. Estoy comprometido a seguir creciendo como profesional en el campo de la informática.'),
          )),
        ],
      ),
    );
  }
}
