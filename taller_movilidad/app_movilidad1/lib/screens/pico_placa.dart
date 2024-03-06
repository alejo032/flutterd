import 'package:flutter/material.dart';

class picoPlaca extends StatefulWidget {
  const picoPlaca({super.key});

  @override
  State<picoPlaca> createState() => _picoPlacaState();
}




class _picoPlacaState extends State<picoPlaca> {
  
  TextEditingController goldopicoyplacaController = TextEditingController();
  String resultado = '';


void dia() {
  try {
    int goldopicoyplaca = int.parse(goldopicoyplacaController.text);
    String dia ='';
    if(goldopicoyplaca == 1 || goldopicoyplaca == 0){
      dia = "Lunes";
    } else if(goldopicoyplaca == 2 || goldopicoyplaca == 3){
      dia = "Martes";
    } else if(goldopicoyplaca == 4 || goldopicoyplaca == 5){
      dia = "Miercoles";
    } else if(goldopicoyplaca == 6 || goldopicoyplaca == 7){
      dia = "Jueves";
    } else {
      dia = "Viernes";
    }
    setState(() {
      resultado = 'El día es: $dia';
    });
  } catch (e) {
    setState(() {
      resultado = 'No se puede calcular, verifique';
    });
  }
}



  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: const Text("Pico y placa",style: TextStyle(color: Colors.amber),),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          width: 400,
          height: 350,
          color: Colors.green,
          child: Column(
            children: [
              TextField(
                controller: goldopicoyplacaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'ingrese ultimo numero de su placa'),
                maxLength: 1,
              ),
              const SizedBox(
                height: 15,
                ),
                ElevatedButton(onPressed: dia, child: const Text("buscar")),
                SizedBox(
                height: 15,
                ),
                Text('Resultado: $resultado')
            ],
          ),
          
        ),
        
      ),
    );
  }
}