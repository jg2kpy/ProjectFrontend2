class Reserva {
  final int? id;
  final String? nombre;
  final String? apellido;
  final String? telefono;
  final String? email;
  final String? ruc;
  final String? cedula;
  final String? tipoPersona;
  final String? fechaNacimiento;

  const Reserva({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.email,
    required this.ruc,
    required this.cedula,
    required this.tipoPersona,
    required this.fechaNacimiento,
  });
}
