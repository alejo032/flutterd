import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Proyecto {
  final String id;
  final String nombreProyecto;
  final int puntajeProyecto;
  final String Foto;

  Proyecto({
    required this.id,
    required this.nombreProyecto,
    required this.puntajeProyecto,
    required this.Foto,
  });

  factory Proyecto.fromJson(Map<String, dynamic> json) {
    return Proyecto(
      id: json['_id'],
      nombreProyecto: json['nombreProyecto'],
      puntajeProyecto: json['puntajeProyecto'],
      Foto: json['Foto'],
    );
  }
}

Future<List<Proyecto>> fetchPosts() async {
  final response = await http.get(Uri.parse('https://apiproyects.onrender.com/proyecto'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    final List<dynamic> proyectosJson = jsonData['msg'];
    return proyectosJson.map((json) => Proyecto.fromJson(json)).toList();
  } else {
    throw Exception('Fallo la carga de los proyectos');
  }
}

class ListarProyectos extends StatefulWidget {
  const ListarProyectos({Key? key}) : super(key: key);

  @override
  State<ListarProyectos> createState() => _ListarProyectosState();
}

class _ListarProyectosState extends State<ListarProyectos> {
  late List<Proyecto> proyectos;
  late List<Proyecto> filteredProyectos;

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProyectos = [];
    fetchPosts().then((list) {
      setState(() {
        proyectos = list;
        filteredProyectos = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proyectos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  filteredProyectos = proyectos
                      .where((proyecto) =>
                          proyecto.nombreProyecto.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                labelText: "Buscar proyecto",
                hintText: "Ingrese el nombre del proyecto",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProyectos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredProyectos[index].nombreProyecto),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(filteredProyectos[index].puntajeProyecto.toString()),
                      if (filteredProyectos[index].Foto.isNotEmpty)
                        Image.memory(
                          base64Decode(filteredProyectos[index].Foto),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          mostrarVentanaEdicion(context, filteredProyectos[index]);
                          print('Editar');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          eliminarProyecto(filteredProyectos[index]);
                          print('Eliminar');
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> editarProyecto(Proyecto proyecto) async {
    const String url = 'https://apiproyects.onrender.com/proyecto';

    final Map<String, dynamic> datosActualizados = {
      '_id': proyecto.id,
      'nombreProyecto': proyecto.nombreProyecto,
      'puntajeProyecto': proyecto.puntajeProyecto,
      'Foto': proyecto.Foto,
    };

    final String cuerpoJson = jsonEncode(datosActualizados);

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: cuerpoJson,
      );

      if (response.statusCode == 200) {
        print('Proyecto editado con éxito');
        fetchPosts().then((list) {
          setState(() {
            proyectos = list;
            filteredProyectos = list;
          });
        });
      } else {
        print('Error al editar producto: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');
    }
  }

  void mostrarVentanaEdicion(BuildContext context, Proyecto proyecto) {
    TextEditingController nombreProyectoController =
        TextEditingController(text: proyecto.nombreProyecto);
    TextEditingController puntajeProyectoController =
        TextEditingController(text: proyecto.puntajeProyecto.toString());
    TextEditingController FotoController =
        TextEditingController(text: proyecto.Foto);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar proyecto'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nombreProyectoController,
                  decoration: const InputDecoration(labelText: 'Nombre proyecto'),
                ),
                TextField(
                  controller: puntajeProyectoController,
                  decoration: const InputDecoration(labelText: 'Puntaje proyecto'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: FotoController,
                  decoration:
                      const InputDecoration(labelText: 'Foto'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                int puntajeProyecto = int.parse(puntajeProyectoController.text);

                Proyecto proyectoActualizada = Proyecto(
                  id: proyecto.id,
                  nombreProyecto: nombreProyectoController.text,
                  puntajeProyecto: puntajeProyecto,
                  Foto: FotoController.text,
                );
                editarProyecto(proyectoActualizada);
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void eliminarProyecto(Proyecto proyecto) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar eliminación"),
          content: Text("¿Estás seguro de que deseas eliminar este producto?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  String url = 'https://apiproyects.onrender.com/proyecto?id=${proyecto.id}';
                  final response = await http.delete(Uri.parse(url));

                  if (response.statusCode == 200) {
                    print('Producto con ID ${proyecto.id} eliminado correctamente.');
                    fetchPosts().then((list) {
                      setState(() {
                        proyectos = list;
                        filteredProyectos = list;
                      });
                    });
                  } else {
                    print('Error al eliminar producto: ${response.statusCode}');
                  }
                } catch (e) {
                  print('Error al eliminar producto: $e');
                }
              },
              child: Text("Eliminar"),
            ),
          ],
        );
      },
    );
  }
}