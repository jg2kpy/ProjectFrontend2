import 'package:flutter/material.dart';
import 'package:project_frontend_2/services/reserva_service.dart';
import 'package:project_frontend_2/widgets/custom_input_field.dart';

import '../models/reserva.dart';
import '../theme/app_theme.dart';

class AgregarReservaScreen extends StatelessWidget {
  final Reserva reserva;

  const AgregarReservaScreen({super.key, required this.reserva});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final Map<String, String> formValues = {
      'idEmpleado': reserva.idEmpleado.toString(),
      'idCliente':
          reserva.idCliente != null ? reserva.idCliente.toString() : '',
      'horaInicioCadena': reserva.horaInicioCadena.toString(),
      'horaFinCadena': reserva.horaFinCadena.toString(),
      'fechaCadena': reserva.fechaCadena.toString(),
      'observacion': '',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar Reserva'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //Agregamos un inputfield que actualiza un valor a _searchText
                    children: const [
                      Center(child: Text('Paso 3 de 3')),
                      SizedBox(height: 20),
                      LinearProgressIndicator(
                        value: 1,
                        minHeight: 5,
                        color: AppTheme.primary,
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                const Text('Datos de la reserva'),
                const SizedBox(height: 20),
                CustomInputField(
                  helperText: formValues['idCliente'] != "0"
                      ? formValues['idCliente']
                      : 'ID Cliente',
                  hintText: formValues['idCliente'] != "0"
                      ? formValues['idCliente']
                      : 'ID Cliente',
                  labelText: formValues['idCliente'] != "0"
                      ? formValues['idCliente']
                      : 'ID Cliente',
                  formProperty: 'idCliente',
                  enabled: formValues['idCliente'] == "0",
                  icon: Icons.remove_red_eye,
                  formValues: formValues,
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  helperText: 'Observacion',
                  hintText: 'Observacion',
                  labelText: 'Observacion',
                  formProperty: 'observacion',
                  icon: Icons.remove_red_eye,
                  formValues: formValues,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    late Future<String> respuesta =
                        ReservaService.agregarReserva(formValues);
                    respuesta.then(
                      (value) => {
                        if (value == 'OK')
                          {
                            Navigator.pushNamed(context, 'reserva'),
                          }
                        else
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Error al agregar la reserva'),
                              ),
                            )
                          }
                      },
                    );
                  },
                  child: const Text('Agregar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
