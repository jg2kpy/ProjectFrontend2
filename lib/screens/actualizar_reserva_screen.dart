import 'package:flutter/material.dart';
import 'package:project_frontend_2/services/reserva_service.dart';
import 'package:project_frontend_2/widgets/custom_input_field.dart';

class ActualizarReservaScreen extends StatelessWidget {
  final int? idReserva;

  const ActualizarReservaScreen({super.key, this.idReserva});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final Map<String, String> formValues = {
      'ID': idReserva.toString(),
      'observacion': '',
      'flagAsistio': '',
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
                const Text('Datos de la reserva'),
                const SizedBox(height: 20),
                CustomInputField(
                  helperText: '$idReserva',
                  hintText: '$idReserva',
                  labelText: '$idReserva',
                  formProperty: 'ID',
                  enabled: false,
                  icon: Icons.numbers,
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
                CustomInputField(
                  helperText: 'S',
                  hintText: 'S',
                  labelText: 'Asistio',
                  formProperty: 'flagAsistio',
                  icon: Icons.check,
                  formValues: formValues,
                ),
                ElevatedButton(
                  onPressed: () {
                    late Future<String> respuesta =
                        ReservaService.actualizarReserva(formValues);
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
                                content: Text('Error al editar la reserva'),
                              ),
                            )
                          }
                      },
                    );
                  },
                  child: const Text('Actualizar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
