class PEPedidoDetalle {
  int nroPedidoDetalle = 0;
  int nroPedido = 0;
  String fecha = '';
  String codigoProducto = '';
  String codsap = '';
  String descripcion = '';
  double cantidad = 0.0;
  double importe = 0.0;
  double monto = 0.0;

  PEPedidoDetalle({
    required this.nroPedidoDetalle,
    required this.nroPedido,
    required this.fecha,
    required this.codigoProducto,
    required this.codsap,
    required this.descripcion,
    required this.cantidad,
    required this.importe,
    required this.monto,
  });

  PEPedidoDetalle.fromJson(Map<String, dynamic> json) {
    nroPedidoDetalle = json['nroPedidoDetalle'];
    nroPedido = json['nroPedido'];
    fecha = json['fecha'] ?? '';
    codigoProducto = json['codigoProducto'] ?? '';
    codsap = json['codsap'] ?? '';
    descripcion = json['descripcion'] ?? '';
    cantidad = json['cantidad'];
    importe = json['importe'];
    monto = json['monto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nroPedidoDetalle'] = nroPedidoDetalle;
    data['nroPedido'] = nroPedido;
    data['fecha'] = fecha;
    data['codigoProducto'] = codigoProducto;
    data['codsap'] = codsap;
    data['descripcion'] = descripcion;
    data['cantidad'] = cantidad;
    data['importe'] = importe;
    data['monto'] = monto;

    return data;
  }
}
