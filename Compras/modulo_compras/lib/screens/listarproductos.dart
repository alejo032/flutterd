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
  final response = await http.get(Uri.parse('https://backendexamen-f4y7.onrender.com/producto'));

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
  late List<Producto> productos;
  late List<Producto> filteredProductos;

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProductos = [];
    fetchPosts().then((list) {
      setState(() {
        productos = list;
        filteredProductos = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  filteredProductos = productos
                      .where((producto) =>
                          producto.nombreProducto.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                labelText: "Buscar producto",
                hintText: "Ingrese el nombre del producto",
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
              itemCount: filteredProductos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredProductos[index].nombreProducto),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(filteredProductos[index].precioProducto.toString()),
                      Text(filteredProductos[index].ivaProducto.toString()),
                      Text(filteredProductos[index].Existencias.toString()),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          mostrarVentanaEdicion(context, filteredProductos[index]);
                          print('Editar');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          eliminarProducto(filteredProductos[index]);
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

  Future<void> editarProducto(Producto producto) async {
    const String url = 'https://backendexamen-f4y7.onrender.com/producto';

    final Map<String, dynamic> datosActualizados = {
      '_id': producto.id,
      'nombreProducto': producto.nombreProducto,
      'precioProducto': producto.precioProducto,
      'ivaProducto': producto.ivaProducto,
      'Existencias': producto.Existencias,
    };

    final String cuerpoJson = jsonEncode(datosActualizados);

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: cuerpoJson,
      );

      if (response.statusCode == 200) {
        print('Producto editado con éxito');
        fetchPosts().then((list) {
          setState(() {
            productos = list;
            filteredProductos = list;
          });
        });
      } else {
        print('Error al editar producto: ${response.reasonPhrase}');
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
                      const InputDecoration(labelText: 'IVA Producto'),
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
                int precioProducto = int.parse(precioProductoController.text);
                int ivaProducto = int.parse(ivaProductoController.text);
                int Existencias = int.parse(ExistenciasController.text);

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
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  String url = 'https://backendexamen-f4y7.onrender.com/producto?id=${producto.id}';
                  final response = await http.delete(Uri.parse(url));

                  if (response.statusCode == 200) {
                    print('Producto con ID ${producto.id} eliminado correctamente.');
                    fetchPosts().then((list) {
                      setState(() {
                        productos = list;
                        filteredProductos = list;
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


