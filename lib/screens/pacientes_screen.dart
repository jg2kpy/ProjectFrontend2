import 'package:flutter/material.dart';
import 'package:project_frontend_2/models/paciente.dart';
import 'package:project_frontend_2/services/services.dart';
import 'package:project_frontend_2/theme/app_theme.dart';
import 'package:project_frontend_2/widgets/custom_input_field.dart';
import 'package:project_frontend_2/widgets/custom_patien_card.dart';

class PacienteScreen extends StatefulWidget {
  const PacienteScreen({super.key});

  @override
  State<PacienteScreen> createState() => _PacienteScreen();
}

class _PacienteScreen extends State<PacienteScreen> {
  late Future<List<Paciente>> _listadoPacientes;
  String _searchText = '';
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
        title: const Text('Pacientes'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //Agregamos un inputfield que actualiza un valor a _searchText
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Buscar pacientes',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: ((value) => {
                        setState(
                          (() => {_searchText = value}),
                        )
                      }),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder(
                future: _listadoPacientes,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        if (_searchText == '') {
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
                        } else {
                          if (snapshot.data![index].nombre!.toLowerCase().contains(_searchText.toLowerCase()) ||
                              (snapshot.data![index].apellido != null &&
                                  snapshot.data![index].apellido!.toLowerCase().contains(_searchText.toLowerCase()))) {
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
                          } else {
                            return Container();
                          }
                        }
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Error al obtener los pacientes');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'AgregarPaciente');
        },
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
