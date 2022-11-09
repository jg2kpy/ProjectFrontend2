// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CustomFichaCard extends StatelessWidget {
  final int? idFichaClinica;
  final String? fechaHora;
  final String? motivoConsulta;
  final String? diagnostico;
  final String? observacion;
  final int? idLocal;
  final int? idEmpleado;
  final String? nombreEmpleado;
  final String? apellidoEmpleado;
  final int? idCliente;
  final String? nombreCliente;
  final String? apellidoCliente;
  final int? idTipoProducto;
  final int? idCategoria;
  final String? fechaHoraCadena;
  final String? fechaHoraCadenaFormateada;
  final String? fechaDesdeCadena;
  final String? fechaHastaCadena;
  final String? todosLosCampos;

  const CustomFichaCard({
    Key? key,
      this.idFichaClinica,
      this.fechaHora,
      this.motivoConsulta,
      this.diagnostico,
      this.observacion,
      this.fechaHoraCadena,
      this.fechaHoraCadenaFormateada,
      this.fechaDesdeCadena,
      this.fechaHastaCadena,
      this.todosLosCampos,
      this.idLocal,
      this.idEmpleado,
      this.nombreEmpleado,
      this.apellidoEmpleado,
      this.idCliente,
      this.nombreCliente,
      this.apellidoCliente,
      this.idTipoProducto,
      this.idCategoria
  }) : super(key: key);

  //Agregamos el campo de informacion de un cliente en un modal
  void displayDialogAndroid(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          title: Text('$idFichaClinica'),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(10)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Datos de la ficha clinica'),
              const SizedBox(height: 20),
              Text('ID: $idFichaClinica'),
              Text('Fecha: $fechaHora'),
              Text('Motivo Consulta: $motivoConsulta'),
              Text('Diagnostico: $diagnostico'),
              Text('Observacion: $observacion'),
              Text('Empleado: $nombreEmpleado $apellidoEmpleado'),
              Text('Cliente: $nombreCliente $apellidoCliente'),
              Text('ID Categoria: $idCategoria'),
              Text('ID Tipo Producto: $idTipoProducto'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            ),
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
            leading: const Icon(Icons.article, color: AppTheme.primary),
            title: Text("ID: ${idFichaClinica}"),
            subtitle: Text("Diagnostico: ${diagnostico ?? ''}"),
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
                  onPressed: () {},
                  child: const Text(
                    'Editar',
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
