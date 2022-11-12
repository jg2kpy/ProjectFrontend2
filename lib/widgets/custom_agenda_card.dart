// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:project_frontend_2/screens/actualizar_reserva_screen.dart';
import 'package:project_frontend_2/services/reserva_service.dart';

import '../theme/app_theme.dart';

class CustomAgendaCard extends StatelessWidget {
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

  const CustomAgendaCard({
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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.design_services, color: AppTheme.primary),
            title: Text("${horaInicioCadena} - ${horaFinCadena}"),
            subtitle: Text("Cliente : ${nombreCliente ?? ''} ${apellidoCliente ?? ''}"),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                    'Seleccionar',
                    style: TextStyle(color: AppTheme.primary),
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
