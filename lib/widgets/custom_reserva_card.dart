// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:project_frontend_2/screens/actualizar_reserva_screen.dart';
import 'package:project_frontend_2/services/reserva_service.dart';

import '../theme/app_theme.dart';

class CustomReservaWidget extends StatelessWidget {
  final int? idReserva;
  final String? fechaCadena;
  final String? fecha;
  final String? horaInicioCadena;
  final String? horaFinCadena;
  final int? idEmpleado;
  final int? idCliente;
  final String? nombreEmpleado;
  final String? apellidoEmpleado;
  final String? nombreCliente;
  final String? apellidoCliente;
  final String? observacion;
  final String? flagAsistio;

  const CustomReservaWidget({
    Key? key,
    this.idReserva,
    this.fechaCadena,
    this.fecha,
    this.horaInicioCadena,
    this.horaFinCadena,
    this.idEmpleado,
    this.idCliente,
    this.nombreEmpleado,
    this.apellidoEmpleado,
    this.nombreCliente,
    this.apellidoCliente,
    this.observacion,
    this.flagAsistio,
  }) : super(key: key);

  //Agregamos el campo de informacion de un cliente en un modal
  void displayDialogAndroid(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          title: const Text('Informacion de la reserva'),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(10)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Datos del paciente'),
              const SizedBox(height: 20),
              Text('ID: $idReserva'),
              Text('Fecha: $fecha'),
              Text('Hora Inicio: $horaInicioCadena'),
              Text('Hora Fin: $horaFinCadena'),
              Text('Nombre Empleado: $nombreEmpleado $apellidoEmpleado'),
              Text('Nombre Cliente: $nombreCliente $apellidoCliente'),
              Text('Observacion: $observacion'),
              Text('Asistio: $flagAsistio'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Aceptar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child:
                  const Text('Cancelar', style: TextStyle(color: Colors.red)),
            )
          ],
        );
      },
    );
  }

  void displayDialogCancelar(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          title: const Text('Estas seguro que desea cancelar'),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(10)),
          actions: [
            TextButton(
              onPressed: () => ReservaService.cancelarReserva(idReserva),
              child: const Text('Si', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.design_services, color: AppTheme.primary),
            title: Text("${fecha}"),
            subtitle: Text(
                "Empleado : ${nombreEmpleado ?? ''} ${apellidoEmpleado ?? ''}"),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => displayDialogAndroid(context),
                  child: const Text(
                    'Informacion',
                    style: TextStyle(color: AppTheme.primary),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActualizarReservaScreen(
                            idReserva: idReserva,
                          ),
                        ));
                  },
                  child: const Text(
                    'Editar',
                    style: TextStyle(color: AppTheme.primary),
                  ),
                ),
                TextButton(
                  onPressed: () => displayDialogCancelar(context),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Color.fromARGB(255, 196, 19, 19)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
