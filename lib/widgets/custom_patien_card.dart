// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CustomPatienCard extends StatelessWidget {
  final int? id;
  final String? nombre;
  final String? apellido;
  final String? telefono;
  final String? email;
  final String? ruc;
  final String? cedula;
  final String? tipoPersona;
  final String? fechaNacimiento;

  const CustomPatienCard({
    Key? key,
    this.id,
    this.nombre,
    this.apellido,
    this.telefono,
    this.email,
    this.ruc,
    this.cedula,
    this.tipoPersona,
    this.fechaNacimiento,
  }) : super(key: key);

  //Agregamos el campo de informacion de un cliente en un modal
  void displayDialogAndroid(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          title: nombre != null
              ? Text('$nombre $apellido')
              : const Text('Paciente'),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(10)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Datos del paciente'),
              const SizedBox(height: 20),
              Text('Telefono: $telefono'),
              Text('Email: $email'),
              Text('Ruc: $ruc'),
              Text('Cedula: $cedula'),
              Text('Tipo de persona: $tipoPersona'),
              Text('Fecha de nacimiento: $fechaNacimiento'),
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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: AppTheme.primary),
            title: Text("${nombre} ${apellido}"),
            subtitle: Text("Telefono : ${telefono ?? ''}"),
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
