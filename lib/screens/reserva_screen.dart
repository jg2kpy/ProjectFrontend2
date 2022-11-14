import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:project_frontend_2/models/reserva.dart';
import 'package:project_frontend_2/theme/app_theme.dart';
import 'package:project_frontend_2/widgets/custom_reserva_card.dart';

import '../services/reserva_service.dart';

class ReservaScreen extends StatefulWidget {
  const ReservaScreen({super.key});

  @override
  State<ReservaScreen> createState() => _ReservaScreen();
}

class _ReservaScreen extends State<ReservaScreen> {
  late Future<List<Reserva>> _listadoReserva;

  String _searchFisio = "";
  String _searchPaciente = "";
  DateTime? _searchFechaDesde;
  DateTime? _searchFechaHasta;

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
      body: Column(
        children: [
          ExpansionTile(
            title: const Text('Filtros'),
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //Agregamos un inputfield que actualiza un valor a _searchText
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Nombre o Apellido de Empleado',
                        prefixIcon: Icon(Icons.person),
                      ),
                      onChanged: ((value) => setState(() => {_searchFisio = value})),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Nombre o Apellido de Cliente',
                        prefixIcon: Icon(Icons.person),
                      ),
                      onChanged: ((value) => setState(() => {_searchPaciente = value})),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: DateTimeFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Fecha desde',
                              labelText: 'Fecha desde',
                              prefixIcon: Icon(Icons.date_range),
                            ),
                            mode: DateTimeFieldPickerMode.date,
                            autovalidateMode: AutovalidateMode.always,
                            onDateSelected: (DateTime value) {
                              setState(() => {_searchFechaDesde = value});
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DateTimeFormField(
                            initialValue: _searchFechaHasta,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Fecha hasta',
                              labelText: 'Fecha hasta',
                              prefixIcon: Icon(Icons.date_range),
                            ),
                            mode: DateTimeFieldPickerMode.date,
                            autovalidateMode: AutovalidateMode.always,
                            onDateSelected: (DateTime value) {
                              setState(() => {_searchFechaHasta = value});
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () => setState(() {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, 'reserva');
                      }),
                      child: const Text('Limpiar'),
                    ),
                  ],
                ),
              )
            ],
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder(
                future: _listadoReserva,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        bool flagFisio = _searchFisio == "" ||
                            ((snapshot.data![index].nombreEmpleado != null &&
                                    snapshot.data![index].nombreEmpleado!
                                        .toLowerCase()
                                        .contains(_searchFisio.toLowerCase())) ||
                                (snapshot.data![index].apellidoEmpleado != null &&
                                    snapshot.data![index].apellidoEmpleado!
                                        .toLowerCase()
                                        .contains(_searchFisio.toLowerCase())));

                        bool flagPaciente = _searchPaciente == "" ||
                            ((snapshot.data![index].nombreCliente != null &&
                                    snapshot.data![index].nombreCliente!
                                        .toLowerCase()
                                        .contains(_searchPaciente.toLowerCase())) ||
                                (snapshot.data![index].apellidoCliente != null &&
                                    snapshot.data![index].apellidoCliente!
                                        .toLowerCase()
                                        .contains(_searchPaciente.toLowerCase())));

                        DateTime fecha = DateTime.parse(snapshot.data![index].fecha!);
                        bool flagDesde = _searchFechaDesde == null ||
                            (_searchFechaDesde != null && fecha.isAfter(_searchFechaDesde!));
                        bool flagHasta = _searchFechaHasta == null ||
                            (_searchFechaHasta != null && fecha.isBefore(_searchFechaHasta!));

                        if (flagFisio && flagPaciente && flagDesde && flagHasta) {
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
                        } else {
                          return Container();
                        }
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Error al obtener las reservas');
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
          Navigator.pushNamed(context, 'elegirDoctor');
        },
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
