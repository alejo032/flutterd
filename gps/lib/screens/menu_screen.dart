import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _direccion = '';
  Position? _currentPosition; // Stores the latest position
  StreamSubscription<Position>? _positionSubscription;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    // Verifica si el permiso ya fue otorgado
    var status = await Permission.location.status;
    if (status.isDenied) {
      // Solicitar el permiso al usuario
      status = await Permission.location.request();
    }

    if (status.isGranted) {
      // Iniciar la suscripción a la ubicación actual
      _positionSubscription = Geolocator.getPositionStream().listen((position) {
        setState(() {
          _currentPosition = position;
          _getAddressFromDaneGeovisor(_currentPosition!.latitude, _currentPosition!.longitude);
        });
      });
    } else {
      // Mostrar un mensaje al usuario indicando que no se ha otorgado el permiso
      print('El usuario no ha otorgado el permiso de ubicación');
    }
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    super.dispose();
  }

  Future<void> _getAddressFromDaneGeovisor(double latitude, double longitude) async {
    final url =
        'https://maps.googleapis.com/maps/api/js/GeocodeService.Search?5m2&1d$latitude&2d$longitude&8m2&1scountry&2sco&9ses-419&callback=_xdc_._g70o6l&key=AIzaSyAOha4Su8EqOFQfDE8NjrS_KdSHfu50WkA&token=28787';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _direccion = data['features'][0]['properties']['direccion'];
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi ubicación actual: '),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Check if _currentPosition is not null before accessing its properties
            _currentPosition != null
                ? Text('Latitud: ${_currentPosition!.latitude}')
                : const Text('Obteniendo latitud...'),
            _currentPosition != null
                ? Text('Longitud: ${_currentPosition!.longitude}')
                : const Text('Obteniendo longitud...'),
            Text(_direccion != '' ? 'Dirección: $_direccion' : ''),
          ],
        ),
      ),
    );
  }
}
