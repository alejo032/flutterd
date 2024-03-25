import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Proveedor {
  final String id;
  final String nombreProveedor;
  final String Nombrecontactoproveedor;
  final int Telefono;
  final String Direccion;
  final int Nit;

  Proveedor({
    required this.id,
    required this.nombreProveedor,
    required this.Nombrecontactoproveedor,
    required this.Telefono,
    required this.Direccion,
    required this.Nit,
  });

  factory Proveedor.fromJson(Map<String, dynamic> json) {
    return Proveedor(
      id: json['_id'],
      nombreProveedor: json['nombreProveedor'],
      Nombrecontactoproveedor: json['Nombrecontactoproveedor'],
      Telefono: json['Telefono'],
      Direccion: json['Direccion'],
      Nit: json['Nit'],
    );
  }
}

Future<List<Proveedor>> fetchPosts() async {
  final response = await http
      .get(Uri.parse('https://backendexamen-f4y7.onrender.com/proveedor'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    final List<dynamic> proveedoresJson = jsonData['msg'];
    return proveedoresJson.map((json) => Proveedor.fromJson(json)).toList();
  } else {
    throw Exception('Fallo la carga de los proveedores');
  }
}

class ListarProveedores extends StatefulWidget {
  const ListarProveedores({Key? key}) : super(key: key);

  @override
  State<ListarProveedores> createState() => _ListarProveedoresState();
}

class _ListarProveedoresState extends State<ListarProveedores> {
  // Método para editar una exportación
  Future<void> editarProveedor(Proveedor proveedor) async {
    // URL de la API donde se encuentra el recurso a editar
    const String url = 'https://backendexamen-f4y7.onrender.com/proveedor';

    // Convierte los datos de la exportación a un formato que la API pueda entender (JSON)
    final Map<String, dynamic> datosActualizados = {
      // Aquí debes incluir los campos que deseas actualizar
      '_id': proveedor.id,
      'nombreProveedor': proveedor.nombreProveedor,
      'Nombrecontactoproveedor': proveedor.Nombrecontactoproveedor,
      'Telefono': proveedor.Telefono,
      'Direccion': proveedor.Direccion,
      'Nit': proveedor.Nit,
      
    };
    print('Datos actualizados:');
    print(datosActualizados);

    // Codificar los datos a JSON
    final String cuerpoJson = jsonEncode(datosActualizados);

    try {
      // Realiza la solicitud PUT al servidor
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json'
        }, // Establecer la cabecera para indicar que el cuerpo es JSON
        body: cuerpoJson, // Pasar el cuerpo codificado JSON
      );

      // Verifica si la solicitud fue exitosa (código de estado 200)
      if (response.statusCode == 200) {
        print('producto editado con éxito');
        setState(() {});
      } else {
        print('Error al editar exportación: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');
    }
  }

  void mostrarVentanaEdicion(BuildContext context, Proveedor proveedor) {
    TextEditingController nombreProveedorController =
        TextEditingController(text: proveedor.nombreProveedor);
    TextEditingController NombrecontactoproveedorController =
        TextEditingController(text: proveedor.Nombrecontactoproveedor);
    TextEditingController TelefonoController =
        TextEditingController(text: proveedor.Telefono.toString());
    TextEditingController DireccionController =
        TextEditingController(text: proveedor.Direccion);
    TextEditingController NitController =
        TextEditingController(text: proveedor.Nit.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar proveedor'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nombreProveedorController,
                  decoration: const InputDecoration(labelText: 'Nombre Proveedor'),
                ),
                TextField(
                  controller: NombrecontactoproveedorController,
                  decoration: const InputDecoration(labelText: 'Nombre contacto proveedor'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: TelefonoController,
                  decoration:
                      const InputDecoration(labelText: 'Telefono'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: DireccionController,
                  decoration:
                      const InputDecoration(labelText: 'Direccion'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: NitController,
                  decoration:
                      const InputDecoration(labelText: 'NIT'),
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
                // Convertir los valores de texto a tipos numéricos
                int Telefono = int.parse(TelefonoController.text);
                
                int Nit = int.parse(NitController.text);

                // Crear la instancia de Exportacion con los valores convertidos
                Proveedor proveedorActualizada = Proveedor(
                  id: proveedor.id,
                  nombreProveedor: nombreProveedorController.text,
                  Nombrecontactoproveedor: NombrecontactoproveedorController.text,
                  Telefono: Telefono,
                  Direccion: DireccionController.text,
                  Nit: Nit,
                );
                editarProveedor(proveedorActualizada);
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void eliminarProveedor(Proveedor proveedor) async {
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirmar eliminación"),
        content: Text("¿Estás seguro de que deseas eliminar este proveedor?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Cerrar el diálogo
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Cerrar el diálogo
              try {
                // URL de la API para eliminar la exportación
                String url =
                    'https://backendexamen-f4y7.onrender.com/proveedor?id=${proveedor.id}';

                // Realiza la solicitud DELETE a la API
                final response = await http.delete(Uri.parse(url));

                // Verifica si la solicitud fue exitosa (código de estado 200)
                if (response.statusCode == 200) {
                  // La exportación se eliminó correctamente
                  print('La exportación con ID ${proveedor.id} se eliminó correctamente.');
                  setState(() {});
                } else {
                  // Hubo un error al eliminar la exportación
                  print('Error al eliminar la exportación: ${response.statusCode}');
                }
              } catch (e) {
                // Manejo de errores
                print('Error al eliminar la exportación: $e');
              }
            },
            child: Text("Eliminar"),
          ),
        ],
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proveedores'),
      ),
      body: FutureBuilder(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Proveedor> proveedores =
                snapshot.data as List<Proveedor>;
            return ListView.builder(
              itemCount: proveedores.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(proveedores[index].nombreProveedor),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(proveedores[index].Telefono.toString()),
                      Text(proveedores[index].Direccion.toString()),
                      Text(proveedores[index].Nit.toString()),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          mostrarVentanaEdicion(context, proveedores[index]);
                          // Implementar la lógica para editar aquí
                          print('Editar');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          eliminarProveedor(proveedores[index]);
                          // Implementar la lógica para eliminar aquí
                          print('Eliminar');
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
