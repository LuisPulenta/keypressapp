import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../helpers/get_position.dart';
import '../../models/models.dart';

class DisplayPicture4Screen extends StatefulWidget {
  final XFile image;

  const DisplayPicture4Screen({super.key, required this.image});

  @override
  _DisplayPicture4ScreenState createState() => _DisplayPicture4ScreenState();
}

class _DisplayPicture4ScreenState extends State<DisplayPicture4Screen> {
  //----------------------- Variables -----------------------------
  String _observaciones = '';
  final String _observacionesError = '';
  final bool _observacionesShowError = false;

  final int _optionId = -1;
  final String _optionIdError = '';
  final bool _optionIdShowError = false;

  bool apretado = false;

  //----------------------- Pantalla ------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vista previa de la foto')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              width: 300,
              height: 440,
              child: OverflowBox(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: 300,
                    height: 440,
                    child: Image.file(
                      File(widget.image.path),
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            _showObservaciones(),
            _showButtons(),
          ],
        ),
      ),
    );
  }

  //----------------------- _showButtons --------------------------
  Widget _showButtons() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF120E43),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: !apretado
                  ? () {
                      setState(() {
                        apretado = true;
                      });
                      _usePhoto();
                    }
                  : null,
              child: const Text('Usar Foto'),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE03B8B),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Volver a tomar'),
            ),
          ),
        ],
      ),
    );
  }

  //----------------------- _showObservaciones --------------------
  Widget _showObservaciones() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: 'Observaciones...',
          labelText: 'Observaciones',
          errorText: _observacionesShowError ? _observacionesError : null,
          prefixIcon: const Icon(Icons.person),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _observaciones = value;
        },
      ),
    );
  }

  //----------------------- _usePhoto -----------------------------
  void _usePhoto() async {
    Position? position = await getPosition(context);

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position!.latitude,
      position.longitude,
    );

    Photo photo = Photo(
      image: widget.image,
      tipofoto: _optionId,
      observaciones: _observaciones,
      latitud: position.latitude,
      longitud: position.longitude,
      direccion: '${placemarks[0].street} - ${placemarks[0].locality}',
    );

    Response response = Response(isSuccess: true, result: photo);
    Future.delayed(const Duration(milliseconds: 100));
    Navigator.pop(context, response);
  }
}
