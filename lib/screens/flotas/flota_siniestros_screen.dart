import 'package:flutter/material.dart';

class FlotaSiniestrosScreen extends StatelessWidget {
  const FlotaSiniestrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Siniestros'), centerTitle: true),
      body: const Center(child: Text('Siniestros')),
    );
  }
}
