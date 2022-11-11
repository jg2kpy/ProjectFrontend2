class Reserva {
  final int? idReserva;
  final String? fechaCadena;
  final String? fecha;
  final String? horaInicioCadena;
  final String? horaFinCadena;
  final int? idEmpleado;
  final String? nombreEmpleado;
  final String? apellidoEmpleado;
  final int? idCliente;
  final String? nombreCliente;
  final String? apellidoCliente;
  final String? observacion;
  final String? flagAsistio;
  final String? fechaDesdeCadena;
  final String? fechaHastaCadena;

  const Reserva({
    required this.idReserva,
    required this.fechaCadena,
    required this.fecha,
    required this.horaInicioCadena,
    required this.horaFinCadena,
    required this.idEmpleado,
    required this.idCliente,
    required this.apellidoEmpleado,
    required this.nombreEmpleado,
    required this.nombreCliente,
    required this.apellidoCliente,
    required this.observacion,
    required this.flagAsistio,
    required this.fechaDesdeCadena,
    required this.fechaHastaCadena,
  });
}
