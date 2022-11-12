import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:project_frontend_2/services/reserva_service.dart';
import 'package:project_frontend_2/widgets/custom_input_field.dart';

class AgregarReservaScreen extends StatelessWidget {
  const AgregarReservaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final Map<String, String> formValues = {
      'fechaCadena': '',
      'horaInicioCadena': '',
      'horaFinCadena': '',
      'idEmpleado': '',
      'idCliente': '',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Reserva'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                DateTimeFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Fecha',
                    labelText: 'Fecha',
                    icon: Icon(Icons.date_range),
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  onDateSelected: (DateTime value) {
                    formValues['fechaCadena'] = value.toString();
                  },
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  helperText: 'Hora Inicio',
                  hintText: 'Hora Inicio',
                  labelText: 'Hora Inicio',
                  formProperty: 'horaInicioCadena',
                  icon: Icons.timelapse,
                  formValues: formValues,
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  helperText: 'Hora Fin',
                  hintText: 'Hora Fin',
                  labelText: 'Hora Fin',
                  formProperty: 'horaFinCadena',
                  icon: Icons.timelapse,
                  formValues: formValues,
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  helperText: 'ID Empleado',
                  hintText: 'ID Empleado',
                  labelText: 'ID Empleado',
                  formProperty: 'idEmpleado',
                  icon: Icons.person,
                  formValues: formValues,
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  helperText: 'ID Cliente',
                  hintText: 'ID Cliente',
                  labelText: 'ID Cliente',
                  formProperty: 'idCliente',
                  icon: Icons.person,
                  formValues: formValues,
                ),
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
                                content: Text('Error al agregar reserva'),
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
