import 'package:flutter/material.dart';

class FlotasPartesDeTallerScreen extends StatelessWidget {
  const FlotasPartesDeTallerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Partes de Taller'), centerTitle: true),
      body: const Center(child: Text('Partes de Taller')),
    );
  }
}
