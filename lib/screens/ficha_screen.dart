import 'package:flutter/material.dart';
import 'package:project_frontend_2/widgets/custom_ficha_card.dart';

import '../models/models.dart';
import '../services/ficha_service.dart';
import '../theme/app_theme.dart';

void main() => runApp(const FichaScreen());

class FichaScreen extends StatefulWidget {
  const FichaScreen({super.key});

  @override
  State<FichaScreen> createState() => _FichaScreenState();  
}

class _FichaScreenState extends State<FichaScreen> {
  late Future<List<Ficha>> _listadoFicha;

  @override
  void initState() {
    super.initState();
    //Aqui se llama al servicio para obtener los pacientes
    _listadoFicha = FichaService.getFichas();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fichas clinicas'),
      ),
      body: FutureBuilder(
        future: _listadoFicha,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return CustomFichaCard(
                  idFichaClinica: snapshot.data![index].idFichaClinica,
                  fechaHora: snapshot.data![index].fechaHora,
                  motivoConsulta: snapshot.data![index].motivoConsulta,
                  diagnostico: snapshot.data![index].diagnostico,
                  observacion: snapshot.data![index].observacion,
                  idLocal: snapshot.data![index].idLocal,
                  idEmpleado: snapshot.data![index].idEmpleado,
                  idCliente: snapshot.data![index].idCliente,
                  idTipoProducto: snapshot.data![index].idTipoProducto,
                  fechaHoraCadena: snapshot.data![index].fechaHoraCadena,
                  fechaHoraCadenaFormateada: snapshot.data![index].fechaHoraCadenaFormateada,
                  fechaDesdeCadena: snapshot.data![index].fechaDesdeCadena,
                  fechaHastaCadena: snapshot.data![index].fechaHastaCadena,
                  todosLosCampos: snapshot.data![index].todosLosCampos,
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
          Navigator.pushNamed(context, 'AgregarPaciente');
        },
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
