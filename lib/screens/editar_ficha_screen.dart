import 'package:flutter/material.dart';
import 'package:project_frontend_2/services/ficha_service.dart';
import 'package:project_frontend_2/widgets/custom_input_field.dart';

class EditarFichaScreen extends StatelessWidget {

  final int? idFichaClinica;

  const EditarFichaScreen({super.key,this.idFichaClinica});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final Map<String, String> formValues = {
      'idFichaClinica': idFichaClinica.toString(),
      'observacion': '',
    };

    return Scaffold(
        appBar: AppBar(
          title: const Text('Editar Ficha Clínica'),
        ),
        body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text('Datos de la ficha clinica'),
                const SizedBox(height: 20),
                CustomInputField(
                  helperText: '$idFichaClinica',
                  hintText: '$idFichaClinica',
                  labelText: '$idFichaClinica',
                  formProperty: 'idFichaClinica',
                  enabled: false,
                  icon: Icons.person,
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
                ElevatedButton(
                  onPressed: () {
                    late Future<String> respuesta = FichaService.editarFicha(formValues);
                    respuesta.then(
                      (value) => {
                        if (value == 'OK')
                          {
                            Navigator.pushNamed(context, 'ficha'),
                          }
                        else
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Error al editar la ficha'),
                              ),
                            )
                          }
                      },
                    );
                  },
                  child: const Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
      );
  }
}