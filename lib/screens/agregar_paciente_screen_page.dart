import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:project_frontend_2/services/patients_service.dart';
import 'package:project_frontend_2/widgets/custom_input_field.dart';

class AgregarPacienteScreen extends StatelessWidget {
  const AgregarPacienteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final Map<String, String> formValues = {
      'nombre': '',
      'apellido': '',
      'email': '',
      'telefono': '',
      'ruc': '',
      'cedula': '',
      'tipoPersona': '',
      'fechaNacimiento': '',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Paciente'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomInputField(
                  helperText: 'Nombre',
                  hintText: 'Nombre',
                  labelText: 'Nombre',
                  formProperty: 'nombre',
                  icon: Icons.person,
                  formValues: formValues,
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  helperText: 'Apellido',
                  hintText: 'Apellido',
                  labelText: 'Apellido',
                  formProperty: 'apellido',
                  icon: Icons.person,
                  formValues: formValues,
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  helperText: 'Email',
                  hintText: 'Email',
                  labelText: 'Email',
                  formProperty: 'email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  formValues: formValues,
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  helperText: 'Telefono',
                  hintText: 'Telefono',
                  labelText: 'Telefono',
                  formProperty: 'telefono',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  formValues: formValues,
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  helperText: 'RUC',
                  hintText: 'RUC',
                  labelText: 'RUC',
                  formProperty: 'ruc',
                  icon: Icons.document_scanner,
                  formValues: formValues,
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  helperText: 'Cedula',
                  hintText: 'Cedula',
                  labelText: 'Cedula',
                  formProperty: 'cedula',
                  icon: Icons.credit_card,
                  formValues: formValues,
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  helperText: 'Tipo de Persona',
                  hintText: 'Tipo de Persona',
                  labelText: 'Tipo de Persona',
                  formProperty: 'tipoPersona',
                  icon: Icons.person,
                  formValues: formValues,
                ),
                const SizedBox(height: 10),
                DateTimeFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    helperText: 'Fecha de Nacimiento',
                    hintText: 'Fecha de Nacimiento',
                    labelText: 'Fecha de Nacimiento',
                    icon: Icon(Icons.date_range),
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (e) =>
                      (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                  onDateSelected: (DateTime value) {
                    formValues['fechaNacimiento'] = value.toString();
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    print(formValues);
                    //PatientsService.addPaciente(formValues);
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
