import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keypressapp/config/router/app_router.dart';

import '../../utils/colors.dart';
import '../../widgets/widgets.dart';

class FlotaMenuScreen extends StatelessWidget {
  const FlotaMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flota Menú'), centerTitle: true),
      body: _getBody(context),
    );
  }

  //----------------------- _getBody ------------------------------
  Widget _getBody(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.white],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Image.asset('assets/logo.png', height: 40, width: 500),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              appRouter.push('/flotasiniestros');
            },
            child: SizedBox(
              width: ancho,
              child: Boton(
                icon: FontAwesomeIcons.carBurst,
                texto: 'Siniestros',
                color1: flotaColor1,
                color2: flotaColor2,
              ),
            ),
          ),
          const SizedBox(height: 5),

          InkWell(
            onTap: () async {
              appRouter.push('/flotachecklist');
            },
            child: SizedBox(
              width: ancho,
              child: Boton(
                icon: FontAwesomeIcons.listCheck,
                texto: 'Check List',
                color1: flotaColor2,
                color2: flotaColor1,
              ),
            ),
          ),
          const SizedBox(height: 5),

          InkWell(
            onTap: () async {
              appRouter.push('/flotapartesdetaller');
            },
            child: SizedBox(
              width: ancho,
              child: Boton(
                icon: FontAwesomeIcons.gears,
                texto: 'Ordenes de Taller',
                color1: flotaColor1,
                color2: flotaColor2,
              ),
            ),
          ),

          const SizedBox(height: 5),
          InkWell(
            onTap: () async {
              appRouter.push('/flotaturnostaller');
            },
            child: SizedBox(
              width: ancho,
              child: Boton(
                icon: FontAwesomeIcons.wrench,
                texto: 'Turnos Taller',
                color1: flotaColor2,
                color2: flotaColor1,
              ),
            ),
          ),

          const SizedBox(height: 5),

          InkWell(
            onTap: () async {
              appRouter.push('/flotakmpreventivo');
            },
            child: SizedBox(
              width: ancho,
              child: Boton(
                icon: FontAwesomeIcons.toolbox, //Icons.taxi_alert
                texto: 'Km. y Preventivos',
                color1: flotaColor1,
                color2: flotaColor2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
