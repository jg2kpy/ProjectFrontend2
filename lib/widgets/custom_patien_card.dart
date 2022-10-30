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
                  onPressed: () {},
                  child: const Text('Informacion'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Editar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
