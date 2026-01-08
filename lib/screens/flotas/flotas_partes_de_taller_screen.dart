import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:keypressapp/providers/providers.dart';
import 'package:keypressapp/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../components/custom_error_dialog.dart';
import '../../components/loader_component.dart';
import '../../config/theme/app_theme.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';
import '../../widgets/confirm_dialog.dart';
import '../widgets/list_count.dart';
import '../widgets/no_content.dart';

class FlotasPartesDeTallerScreen extends StatefulWidget {
  const FlotasPartesDeTallerScreen({super.key});

  @override
  FlotasPartesDeTallerScreenState createState() =>
      FlotasPartesDeTallerScreenState();
}

class FlotasPartesDeTallerScreenState
    extends State<FlotasPartesDeTallerScreen> {
  //----------------------- Variables -----------------------------
  List<VehiculosPartesTaller> _partestaller = [];
  bool _showLoader = false;
  bool _isFiltered = false;
  String _search = '';

  //----------------------- initState -----------------------------
  @override
  void initState() {
    super.initState();
    _getPartesTaller();
  }

  //----------------------- Pantalla -----------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Ordenes de Taller'),
        centerTitle: true,
        actions: <Widget>[
          _isFiltered
              ? IconButton(
                  onPressed: _removeFilter,
                  icon: const Icon(Icons.filter_none),
                )
              : IconButton(
                  onPressed: _showFilter,
                  icon: const Icon(Icons.filter_alt),
                ),
        ],
      ),
      body: Center(
        child: _showLoader
            ? const LoaderComponent(text: 'Por favor espere...')
            : _getContent(),
      ),
    );
  }

  //------------------------------ _filter --------------------------
  void _filter() {
    if (_search.isEmpty) {
      return;
    }
    List<VehiculosPartesTaller> filteredList = [];
    for (var parteTaller in _partestaller) {
      if (parteTaller.descripcion!.toLowerCase().contains(
            _search.toLowerCase(),
          ) ||
          parteTaller.codVehiculo!.toLowerCase().contains(
            _search.toLowerCase(),
          ) ||
          parteTaller.numcha!.toLowerCase().contains(_search.toLowerCase())) {
        filteredList.add(parteTaller);
      }
    }

    setState(() {
      _partestaller = filteredList;
      _isFiltered = true;
    });

    Navigator.of(context).pop();
  }

  //------------------------------ _removeFilter --------------------------
  void _removeFilter() {
    setState(() {
      _isFiltered = false;
    });
    _getPartesTaller();
  }

  //------------------------------ _showFilter --------------------------
  void _showFilter() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text('Filtrar Partes Taller'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Escriba texto o números a buscar en Descripción, Cód. Vehículo o Patente: ',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 10),
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Criterio de búsqueda...',
                  labelText: 'Buscar',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  _search = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => _filter(),
              child: const Text('Filtrar'),
            ),
          ],
        );
      },
    );
  }

  //------------------------------ _getContent --------------------------
  Widget _getContent() {
    return Column(
      children: <Widget>[
        listCount('Cantidad de Partes Taller: ', _partestaller.length),
        Expanded(
          child: _partestaller.isEmpty
              ? noContent(
                  _isFiltered,
                  'No hay Partes Taller con ese criterio de búsqueda',
                  'No hay Partes Taller registrados',
                )
              : _getListView(),
        ),
      ],
    );
  }

  //------------------------------ _getListView ---------------------------
  Widget _getListView() {
    var f = NumberFormat('#,###', 'es');
    return ListView(
      children: _partestaller.map((e) {
        return Card(
          color: const Color.fromARGB(255, 203, 222, 241),
          shadowColor: Colors.white,
          elevation: 10,
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Container(
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'N°: ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    f.format(e.numero).toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(width: 20),
                                  const Text(
                                    'Fecha: ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('dd/MM/yyyy').format(
                                      DateTime.parse(e.fecha.toString()),
                                    ),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Cód. Vehículo: ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    e.codVehiculo!.trim(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(width: 20),
                                  const Text(
                                    'Chapa: ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    e.numcha.toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Denominación: ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    e.descripcion!,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Km. actual: ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    e.kmHsActual.toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  const Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Fallas reportadas: ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppTheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      e.fallasReportadas!,
                                      maxLines:
                                          3, // Limita el texto a 3 líneas.
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        onPressed: () async {
                          bool result = await showConfirmDialog(
                            context,
                            title: 'Atención!',
                            content:
                                'Está seguro de marcar como Finalizado la Orden de Taller N° ${e.numero}?',
                          );
                          if (result) {
                            _actualizar(e.numero);
                          }
                        },

                        icon: const FaIcon(
                          FontAwesomeIcons.flagCheckered,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  //----------------------- _getPartesTaller -----------------------------
  Future<void> _getPartesTaller() async {
    final appStateProvider = context.read<AppStateProvider>();
    User user = appStateProvider.user;
    setState(() {
      _showLoader = true;
    });

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      setState(() {
        _showLoader = false;
      });
      await customErrorDialog(
        context,
        'Error',
        'Verifica que estés conectado a Internet',
      );
      return;
    }

    Response response = Response(isSuccess: false);

    response = await ApiHelper.getVehiculosPartesTallers(user.codigoCausante);

    if (!response.isSuccess) {
      if (mounted) {
        await customErrorDialog(context, 'Error', response.message);
        return;
      }
    }

    if (mounted) {
      setState(() {
        _showLoader = false;
        _partestaller = response.result;
        _partestaller.sort((a, b) {
          return a.numero.toString().toLowerCase().compareTo(
            b.numero.toString().toLowerCase(),
          );
        });
      });
    }
  }

  //----------------------- _firmarPedido ---------------------------
  void _actualizar(int nro) async {
    setState(() {
      _showLoader = true;
    });

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      setState(() {
        _showLoader = false;
      });
      await customErrorDialog(
        context,
        'Error',
        'Verifica que estés conectado a Internet',
      );
      return;
    }

    Map<String, dynamic> request = {'Nro': nro};

    Response response = Response(isSuccess: false);

    response = await ApiHelper.put(
      '/api/VehiculosPartesTaller/PutParteTaller/',
      nro.toString(),
      request,
    );

    _getPartesTaller();
  }
}
