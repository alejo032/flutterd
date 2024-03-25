import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Producto {
  final String id;
  final String nombreProducto;
  final int precioProducto;
  final int ivaProducto;
  final int Existencias;

  Producto({
    required this.id,
    required this.nombreProducto,
    required this.precioProducto,
    required this.ivaProducto,
    required this.Existencias,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['_id'],
      nombreProducto: json['nombreProducto'],
      precioProducto: json['precioProducto'],
      ivaProducto: json['ivaProducto'],
      Existencias: json['Existencias'],
    );
  }
}

Future<List<Producto>> fetchPosts() async {
  final response = await http
      .get(Uri.parse('https://backendexamen-f4y7.onrender.com/producto'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    final List<dynamic> productosJson = jsonData['msg'];
    return productosJson.map((json) => Producto.fromJson(json)).toList();
  } else {
    throw Exception('Fallo la carga de los productos');
  }
}

class ListarProductos extends StatefulWidget {
  const ListarProductos({Key? key}) : super(key: key);

  @override
  State<ListarProductos> createState() => _ListarProductosState();
}

class _ListarProductosState extends State<ListarProductos> {
  // Método para editar una exportación
  Future<void> editarProducto(Producto producto) async {
    // URL de la API donde se encuentra el recurso a editar
    const String url = 'https://backendexamen-f4y7.onrender.com/producto';

    // Convierte los datos de la exportación a un formato que la API pueda entender (JSON)
    final Map<String, dynamic> datosActualizados = {
      // Aquí debes incluir los campos que deseas actualizar
      '_id': producto.id,
      'nombreProducto': producto.nombreProducto,
      'precioProducto': producto.precioProducto,
      'ivaProducto': producto.ivaProducto,
      'Existencias': producto.Existencias,
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

  void mostrarVentanaEdicion(BuildContext context, Producto producto) {
    TextEditingController nombreProductoController =
        TextEditingController(text: producto.nombreProducto);
    TextEditingController precioProductoController =
        TextEditingController(text: producto.precioProducto.toString());
    TextEditingController ivaProductoController =
        TextEditingController(text: producto.ivaProducto.toString());
    TextEditingController ExistenciasController =
        TextEditingController(text: producto.Existencias.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar producto'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nombreProductoController,
                  decoration: const InputDecoration(labelText: 'Nombre Producto'),
                ),
                TextField(
                  controller: precioProductoController,
                  decoration: const InputDecoration(labelText: 'Precio Producto'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: ivaProductoController,
                  decoration:
                      const InputDecoration(labelText: 'Iva Producto'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: ExistenciasController,
                  decoration:
                      const InputDecoration(labelText: 'Existencias'),
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
                int precioProducto = int.parse(precioProductoController.text);
                int ivaProducto = int.parse(ivaProductoController.text);
                int Existencias = int.parse(ExistenciasController.text);

                // Crear la instancia de Exportacion con los valores convertidos
                Producto productoActualizada = Producto(
                  id: producto.id,
                  nombreProducto: nombreProductoController.text,
                  precioProducto: precioProducto,
                  ivaProducto: ivaProducto,
                  Existencias: Existencias,
                );
                editarProducto(productoActualizada);
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void eliminarProducto(Producto producto) async {
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirmar eliminación"),
        content: Text("¿Estás seguro de que deseas eliminar este producto?"),
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
                    'https://backendexamen-f4y7.onrender.com/producto?id=${producto.id}';

                // Realiza la solicitud DELETE a la API
                final response = await http.delete(Uri.parse(url));

                // Verifica si la solicitud fue exitosa (código de estado 200)
                if (response.statusCode == 200) {
                  // La exportación se eliminó correctamente
                  print('La exportación con ID ${producto.id} se eliminó correctamente.');
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
        title: const Text('Productos'),
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
            List<Producto> productos =
                snapshot.data as List<Producto>;
            return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(productos[index].nombreProducto),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(productos[index].precioProducto.toString()),
                      Text(productos[index].ivaProducto.toString()),
                      Text(productos[index].Existencias.toString()),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          mostrarVentanaEdicion(context, productos[index]);
                          // Implementar la lógica para editar aquí
                          print('Editar');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          eliminarProducto(productos[index]);
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
