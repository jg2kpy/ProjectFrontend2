import 'package:flutter/material.dart';
import 'package:project_frontend_2/services/ficha_service.dart';
import 'package:project_frontend_2/widgets/custom_input_field.dart';

class AgregarFichaScreen extends StatelessWidget {
  const AgregarFichaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final Map<String, String> formValues = {
      'motivoConsulta': '',
      'diagnostico': '',
      'observacion': '',
      'idEmpleado': '',
      'idCliente': '',
      'idTipoProducto': '',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Ficha Clínica'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomInputField(
                  helperText: 'Motivo de Consulta',
                  hintText: 'Motivo de Consulta',
                  labelText: 'Motivo de Consulta',
                  formProperty: 'motivoConsulta',
                  icon: Icons.paste_rounded,
                  formValues: formValues,
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  helperText: 'Diagnóstico',
                  hintText: 'Diagnóstico',
                  labelText: 'Diagnóstico',
                  formProperty: 'diagnostico',
                  icon: Icons.paste_rounded,
                  formValues: formValues,
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  helperText: 'Observación',
                  hintText: 'Observación',
                  labelText: 'Observación',
                  formProperty: 'observacion',
                  icon: Icons.remove_red_eye,
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
                const SizedBox(height: 10),
                CustomInputField(
                  helperText: 'ID Tipo Producto',
                  hintText: 'ID Tipo Producto',
                  labelText: 'ID Tipo Producto',
                  formProperty: 'idTipoProducto',
                  icon: Icons.document_scanner,
                  formValues: formValues,
                ),
                ElevatedButton(
                  onPressed: () {
                    late Future<String> respuesta = FichaService.agregarFicha(formValues);
                    respuesta.then(
                      (value) => {
                        if (value == 'OK')
                          {
                            Navigator.pushNamed(context, 'fichas'),
                          }
                        else
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Error al agregar fichas'),
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
