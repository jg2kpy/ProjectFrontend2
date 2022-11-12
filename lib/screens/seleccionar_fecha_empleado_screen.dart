import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:project_frontend_2/models/reserva.dart';
import 'package:project_frontend_2/screens/seleccionar_agenda_screen.dart';
import 'package:project_frontend_2/theme/app_theme.dart';
import 'package:project_frontend_2/widgets/custom_input_field.dart';

import '../services/reserva_service.dart';

class SelectDoctorScreen extends StatelessWidget {
  const SelectDoctorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Reserva'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: formKey,
            child: Formulario(),
          ),
        ),
      ),
    );
  }
}

class Formulario extends StatelessWidget {
  Formulario({
    Key? key,
  }) : super(key: key);

  final Map<String, String> formValues = {
    'idDoctor': '',
    'fechaCadena': '',
  };
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(child: Text('Paso 1 de 3')),
        const SizedBox(height: 20),
        const LinearProgressIndicator(
          value: 0.33,
          minHeight: 5,
          color: AppTheme.primary,
        ),
        const SizedBox(height: 30),
        CustomInputField(
          helperText: 'ID del Doctor',
          formProperty: 'idDoctor',
          labelText: 'ID del doctor',
          icon: Icons.person,
          formValues: formValues,
        ),
        const SizedBox(height: 10),
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
        ElevatedButton(
          onPressed: () {
            _getReservas(context);
          },
          child: const Text('Siguiente'),
        ),
      ],
    );
  }

  void _getReservas(context) {
    late Future<List<Reserva>> futureReservas = ReservaService.getReservasByDateAndDoctor(formValues);
    futureReservas.then((reservas) {
      if (reservas.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No hay reservas para este doctor en esta fecha'),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SeleccionarAgendaScreen(
              reservas: reservas,
            ),
          ),
        );
      }
    });
  }
}
