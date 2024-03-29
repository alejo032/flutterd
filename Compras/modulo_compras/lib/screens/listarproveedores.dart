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
  final response = await http.get(Uri.parse('https://backendexamen-f4y7.onrender.com/proveedor'));

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
  late List<Proveedor> proveedores;
  late List<Proveedor> filteredProveedores;

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProveedores = [];
    fetchPosts().then((list) {
      setState(() {
        proveedores = list;
        filteredProveedores = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proveedores'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  filteredProveedores = proveedores
                      .where((proveedor) =>
                          proveedor.nombreProveedor.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                labelText: "Buscar proveedor",
                hintText: "Ingrese el nombre del proveedor",
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
              itemCount: filteredProveedores.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredProveedores[index].nombreProveedor),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(filteredProveedores[index].Telefono.toString()),
                      Text(filteredProveedores[index].Direccion),
                      Text(filteredProveedores[index].Nit.toString()),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          mostrarVentanaEdicion(context, filteredProveedores[index]);
                          print('Editar');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          eliminarProveedor(filteredProveedores[index]);
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

  Future<void> editarProveedor(Proveedor proveedor) async {
    const String url = 'https://backendexamen-f4y7.onrender.com/proveedor';

    final Map<String, dynamic> datosActualizados = {
      '_id': proveedor.id,
      'nombreProveedor': proveedor.nombreProveedor,
      'Nombrecontactoproveedor': proveedor.Nombrecontactoproveedor,
      'Telefono': proveedor.Telefono,
      'Direccion': proveedor.Direccion,
      'Nit': proveedor.Nit,
    };

    final String cuerpoJson = jsonEncode(datosActualizados);

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: cuerpoJson,
      );

      if (response.statusCode == 200) {
        print('Proveedor editado con éxito');
        fetchPosts().then((list) {
          setState(() {
            proveedores = list;
            filteredProveedores = list;
          });
        });
      } else {
        print('Error al editar proveedor: ${response.reasonPhrase}');
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
                ),
                TextField(
                  controller: TelefonoController,
                  decoration:
                      const InputDecoration(labelText: 'Teléfono'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: DireccionController,
                  decoration:
                      const InputDecoration(labelText: 'Dirección'),
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
                int Telefono = int.parse(TelefonoController.text);
                int Nit = int.parse(NitController.text);

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
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  String url = 'https://backendexamen-f4y7.onrender.com/proveedor?id=${proveedor.id}';
                  final response = await http.delete(Uri.parse(url));

                  if (response.statusCode == 200) {
                    print('Proveedor con ID ${proveedor.id} eliminado correctamente.');
                    fetchPosts().then((list) {
                      setState(() {
                        proveedores = list;
                        filteredProveedores = list;
                      });
                    });
                  } else {
                    print('Error al eliminar proveedor: ${response.statusCode}');
                  }
                } catch (e) {
                  print('Error al eliminar proveedor: $e');
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