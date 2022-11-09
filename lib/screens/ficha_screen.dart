import 'package:date_field/date_field.dart';
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

  String _searchFisio = "";
  String _searchPaciente = "";
  DateTime? _searchFechaDesde;
  DateTime? _searchFechaHasta;
  String _searchCategoria = "";
  String _searchTipo = "";

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
                        hintText: 'Nombre o Apellido de Fisioterapeuta',
                        prefixIcon: Icon(Icons.person),
                      ),
                      onChanged: ((value) =>
                          setState(() => {_searchFisio = value})),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Nombre o Apellido de Paciente',
                        prefixIcon: Icon(Icons.person),
                      ),
                      onChanged: ((value) =>
                          setState(() => {_searchPaciente = value})),
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
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Categoria',
                        prefixIcon: Icon(Icons.paste_rounded),
                      ),
                      onChanged: ((value) =>
                          setState(() => {_searchCategoria = value})),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Tipo de producto',
                        prefixIcon: Icon(Icons.document_scanner),
                      ),
                      onChanged: ((value) =>
                          setState(() => {_searchTipo = value})),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () => setState(() {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, 'ficha');
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
                future: _listadoFicha,
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
                                        .contains(
                                            _searchFisio.toLowerCase())) ||
                                (snapshot.data![index].apellidoEmpleado !=
                                        null &&
                                    snapshot.data![index].apellidoEmpleado!
                                        .toLowerCase()
                                        .contains(_searchFisio.toLowerCase())));

                        bool flagPaciente = _searchPaciente == "" ||
                            ((snapshot.data![index].nombreCliente != null &&
                                    snapshot.data![index].nombreCliente!
                                        .toLowerCase()
                                        .contains(
                                            _searchPaciente.toLowerCase())) ||
                                (snapshot.data![index].apellidoCliente !=
                                        null &&
                                    snapshot.data![index].apellidoCliente!
                                        .toLowerCase()
                                        .contains(
                                            _searchPaciente.toLowerCase())));

                        DateTime fechaHora =
                            DateTime.parse(snapshot.data![index].fechaHora!);
                        bool flagDesde = _searchFechaDesde == null ||
                            (_searchFechaDesde != null &&
                                fechaHora.isAfter(_searchFechaDesde!));
                        bool flagHasta = _searchFechaHasta == null ||
                            (_searchFechaHasta != null &&
                                fechaHora.isBefore(_searchFechaHasta!));

                        bool flagTipo = _searchTipo == "" ||
                            ((snapshot.data![index].idTipoProducto != null &&
                                snapshot.data![index].idTipoProducto ==
                                    int.parse(_searchTipo)));

                        bool flagCategoria = _searchCategoria == "" ||
                            ((snapshot.data![index].idCategoria != null &&
                                snapshot.data![index].idCategoria ==
                                    int.parse(_searchCategoria)));

                        if (flagFisio &&
                            flagPaciente &&
                            flagDesde &&
                            flagHasta &&
                            flagCategoria &&
                            flagTipo) {
                          return CustomFichaCard(
                            idFichaClinica:
                                snapshot.data![index].idFichaClinica,
                            fechaHora: snapshot.data![index].fechaHora,
                            motivoConsulta:
                                snapshot.data![index].motivoConsulta,
                            diagnostico: snapshot.data![index].diagnostico,
                            observacion: snapshot.data![index].observacion,
                            idLocal: snapshot.data![index].idLocal,
                            idEmpleado: snapshot.data![index].idEmpleado,
                            nombreEmpleado:
                                snapshot.data![index].nombreEmpleado,
                            apellidoEmpleado:
                                snapshot.data![index].apellidoEmpleado,
                            idCliente: snapshot.data![index].idCliente,
                            nombreCliente: snapshot.data![index].nombreCliente,
                            apellidoCliente:
                                snapshot.data![index].apellidoCliente,
                            idTipoProducto:
                                snapshot.data![index].idTipoProducto,
                            idCategoria: snapshot.data![index].idCategoria,
                            fechaHoraCadena:
                                snapshot.data![index].fechaHoraCadena,
                            fechaHoraCadenaFormateada:
                                snapshot.data![index].fechaHoraCadenaFormateada,
                            fechaDesdeCadena:
                                snapshot.data![index].fechaDesdeCadena,
                            fechaHastaCadena:
                                snapshot.data![index].fechaHastaCadena,
                            todosLosCampos:
                                snapshot.data![index].todosLosCampos,
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Error al obtener las fichas clinicas');
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
          Navigator.pushNamed(context, 'AgregarFicha');
        },
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
