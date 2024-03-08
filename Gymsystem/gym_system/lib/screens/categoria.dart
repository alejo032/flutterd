import 'package:flutter/material.dart';

class categoriaScreen extends StatefulWidget {
  const categoriaScreen({super.key});

  @override
  State<categoriaScreen> createState() => _categoriaScreenState();
}

class _categoriaScreenState extends State<categoriaScreen> {
  final GlobalKey<FormState> _formCategoria =
      GlobalKey<FormState>(); //estado del formulario
  String nombre = '';
  String descripcion = '';

  void acceder() {

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear categoria productos'),
        backgroundColor: const Color.fromARGB(255, 28, 85, 131),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.category,
                    ),
                    hintText: "ingrese nombre categoria de productos",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    labelText: 'ingrese nombre categoria de productos',
                    labelStyle: TextStyle(
                      fontSize: 20,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.description_outlined,
                    ),
                    hintText: "ingrese descripcion de categoria de productos",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    labelText: 'ingrese descripcion de categoria de productos',
                    labelStyle: TextStyle(
                      fontSize: 20,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: acceder,
                icon: const Icon(Icons.save_outlined, color: Colors.white),
                label: const Text(
                  'Guardar',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 28, 85, 131) ),
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// crear un proyecto en flutter con el nombre de su proyecto formativo
// selecciones de su proyecto formativo una tabla maestra diferente al login y
// disene en flutter
