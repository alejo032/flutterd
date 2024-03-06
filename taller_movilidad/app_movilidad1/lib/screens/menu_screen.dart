import 'package:app_movilidad1/screens/infracciones.dart';
import 'package:app_movilidad1/screens/pico_placa.dart';
import 'package:flutter/material.dart';



class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movilidad',
          style: TextStyle(color: Colors.white, fontSize: 50),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text('preguntas'),
            subtitle: Text('frecuentes'),
            leading: Icon(
              Icons.people,
              color: Colors.orange,
            ),
            trailing: Icon(Icons.navigate_next),
          ),
          ListTile(
            title: const Text('pico y placa'),
            subtitle: const Text('Conoce tu dia'),
            leading: const Icon(
              Icons.arrow_right_outlined,
              color: Colors.orange,
            ),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              final route =
                  MaterialPageRoute(builder: (context) => const picoPlaca());
              Navigator.push(context, route);
            },
          ),
          ListTile(
            title: const Text('infracciones'),
            subtitle: const Text('Que puedo hacer'),
            leading: const Icon(
              Icons.arrow_right_outlined,
              color: Colors.orange,
            ),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              final route = MaterialPageRoute(
                  builder: (context) => const InfraccionesScreeen());
              Navigator.push(context, route);
            },
          ),
        ],
      ),
    );
  }
}