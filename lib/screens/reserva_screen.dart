import 'package:flutter/material.dart';
import 'package:project_frontend_2/models/reserva.dart';
import 'package:project_frontend_2/screens/agregar_reserva_screen.dart';
import 'package:project_frontend_2/services/services.dart';
import 'package:project_frontend_2/theme/app_theme.dart';
import 'package:project_frontend_2/widgets/custom_patien_card.dart';
import 'package:project_frontend_2/widgets/custom_reserva_card.dart';

import '../services/reserva_service.dart';

class ReservaScreen extends StatefulWidget {
  const ReservaScreen({super.key});

  @override
  State<ReservaScreen> createState() => _ReservaScreen();
}

class _ReservaScreen extends State<ReservaScreen> {
  late Future<List<Reserva>> _listadoReserva;

  @override
  void initState() {
    super.initState();
    //Aqui se llama al servicio para obtener los pacientes
    _listadoReserva = ReservaService.getReservas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservas'),
      ),
      body: FutureBuilder(
        future: _listadoReserva,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return CustomReservaWidget(
                  idReserva: snapshot.data![index].idReserva,
                  fechaCadena: snapshot.data![index].fechaCadena,
                  fecha: snapshot.data![index].fecha,
                  horaInicioCadena: snapshot.data![index].horaInicioCadena,
                  horaFinCadena: snapshot.data![index].horaFinCadena,
                  idEmpleado: snapshot.data![index].idEmpleado,
                  idCliente: snapshot.data![index].idCliente,
                  nombreEmpleado: snapshot.data![index].nombreEmpleado,
                  apellidoEmpleado: snapshot.data![index].apellidoEmpleado,
                  nombreCliente: snapshot.data![index].nombreCliente,
                  apellidoCliente: snapshot.data![index].apellidoCliente,
                  observacion: snapshot.data![index].observacion,
                  flagAsistio: snapshot.data![index].flagAsistio,
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
