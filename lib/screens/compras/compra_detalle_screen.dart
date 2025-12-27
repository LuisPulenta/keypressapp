import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keypressapp/config/theme/app_theme.dart';

import '../../components/components.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';
import '../widgets/list_count.dart';

class CompraDetalleScreen extends StatefulWidget {
  final int compra;
  const CompraDetalleScreen({super.key, required this.compra});

  @override
  State<CompraDetalleScreen> createState() => _CompraDetalleScreenState();
}

class _CompraDetalleScreenState extends State<CompraDetalleScreen> {
  List<PEPedidoDetalle> detallesCompra = [];
  bool _showLoader = false;
  double _totalCompra = 0;

  //------------------- initState ---------------------
  @override
  void initState() {
    super.initState();
    _getCompra();
  }

  //------------------- Pantalla ---------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Detalle Compra ${widget.compra}'),
        centerTitle: true,
      ),
      body: Center(
        child: _showLoader
            ? const LoaderComponent(text: 'Por favor espere...')
            : _getContent(),
      ),
    );
  }

  //------------------------------ _getContent --------------------------
  Widget _getContent() {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: listCount('Cantidad de Detalles: ', detallesCompra.length),
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    "Monto: ",
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    NumberFormat.currency(symbol: '\$').format(_totalCompra),

                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: detallesCompra.isEmpty
              ? Text('No hay Detalles registrados')
              : _getListView(),
        ),
      ],
    );
  }

  //------------------------------ _getContent --------------------------
  Widget _getListView() {
    var f = NumberFormat('#,###', 'es');
    return ListView(
      children: detallesCompra.map((e) {
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
                                children: [
                                  const Text(
                                    'Codigo Producto: ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      e.codigoProducto,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  const Text(
                                    'Cod. Sap.: ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      e.codsap,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Text(
                                    'Descripción: ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      e.descripcion,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Text(
                                    'Cantidad: ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      e.cantidad.toString(),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  const Text(
                                    'Precio: ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      NumberFormat.currency(
                                        symbol: '\$',
                                      ).format(e.importe),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  const Text(
                                    'Monto: ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      NumberFormat.currency(
                                        symbol: '\$',
                                      ).format(e.monto),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                ],
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  //------------------------------ _getCompra --------------------------

  Future<void> _getCompra() async {
    setState(() {
      _showLoader = true;
    });
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      setState(() {});

      await customErrorDialog(
        context,
        'Error',
        'Verifica que estés conectado a Internet',
      );
      setState(() {
        _showLoader = false;
      });
      return;
    }

    Response response = await ApiHelper.getDetalleCompras(
      widget.compra.toString(),
    );

    if (!response.isSuccess) {
      await customErrorDialog(context, 'Error', 'N° de Compra no válido');

      setState(() {
        _showLoader = false;
      });
      return;
    }

    if (!response.isSuccess) {
      if (mounted) {
        await customErrorDialog(context, 'Error', response.message);
        setState(() {
          _showLoader = false;
        });
        return;
      }
    }

    if (mounted) {
      setState(() {
        _showLoader = false;
        detallesCompra = response.result;
      });

      for (var dc in detallesCompra) {
        _totalCompra = _totalCompra + dc.monto;
      }
    }
  }
}
