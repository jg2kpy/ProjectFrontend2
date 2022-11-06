import 'package:flutter/material.dart';
import 'package:project_frontend_2/models/paciente.dart';
import 'package:project_frontend_2/screens/agregar_paciente_screen_page.dart';
import 'package:project_frontend_2/services/services.dart';
import 'package:project_frontend_2/theme/app_theme.dart';
import 'package:project_frontend_2/widgets/custom_patien_card.dart';

import '../routes/app_routes.dart';

class ReservaScreen extends StatefulWidget {
  const ReservaScreen({super.key});

  @override
  State<ReservaScreen> createState() => _ReservaScreen();
}

class _ReservaScreen extends State<ReservaScreen> {
  late Future<List<Paciente>> _listadoPacientes;

  @override
  void initState() {
    super.initState();
    //Aqui se llama al servicio para obtener los pacientes
    _listadoPacientes = PatientsService.getPacientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservas'),
      ),
      body: FutureBuilder(
        future: _listadoPacientes,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return CustomPatienCard(
                  id: snapshot.data![index].id,
                  nombre: snapshot.data![index].nombre,
                  apellido: snapshot.data![index].apellido,
                  telefono: snapshot.data![index].telefono,
                  email: snapshot.data![index].email,
                  ruc: snapshot.data![index].ruc,
                  cedula: snapshot.data![index].cedula,
                  tipoPersona: snapshot.data![index].tipoPersona,
                  fechaNacimiento: snapshot.data![index].fechaNacimiento,
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text('Error al obtener los pacientes');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'AgregarReserva');
        },
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
