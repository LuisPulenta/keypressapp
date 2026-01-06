class VehiculosPartesTaller {
  int numero = 0;
  String? codVehiculo = '';
  String? descripcion = '';
  String? fecha = '';
  String? numcha = '';
  int? kmHsActual = 0;
  String? fallasReportadas = '';
  String? causanteMecanico = '';
  String? fechaAsignacion = '';
  int? finalizadaMecanico = 0;
  String? fechaFinalizadaMecanico = '';

  VehiculosPartesTaller({
    required this.numero,
    required this.codVehiculo,
    required this.descripcion,
    required this.fecha,
    required this.numcha,
    required this.kmHsActual,
    required this.fallasReportadas,
    required this.causanteMecanico,
    required this.fechaAsignacion,
    required this.finalizadaMecanico,
    required this.fechaFinalizadaMecanico,
  });

  VehiculosPartesTaller.fromJson(Map<String, dynamic> json) {
    numero = json['numero'];
    codVehiculo = json['codVehiculo'] ?? '';
    descripcion = json['descripcion'] ?? '';
    fecha = json['fecha'] ?? '';
    numcha = json['numcha'] ?? '';
    kmHsActual = json['kmHsActual'] ?? 0;
    fallasReportadas = json['fallasReportadas'] ?? '';
    causanteMecanico = json['causanteMecanico'] ?? '';
    fechaAsignacion = json['fechaAsignacion'] ?? '';
    finalizadaMecanico = json['finalizadaMecanico'] ?? 0;
    fechaFinalizadaMecanico = json['fechaFinalizadaMecanico'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['numero'] = numero;
    data['codVehiculo'] = codVehiculo;
    data['descripcion'] = descripcion;
    data['fecha'] = fecha;
    data['numcha'] = numcha;
    data['kmHsActual'] = kmHsActual;
    data['fallasReportadas'] = fallasReportadas;
    data['causanteMecanico'] = causanteMecanico;
    data['fechaAsignacion'] = fechaAsignacion;
    data['finalizadaMecanico'] = finalizadaMecanico;
    data['fechaFinalizadaMecanico'] = fechaFinalizadaMecanico;
    return data;
  }
}
