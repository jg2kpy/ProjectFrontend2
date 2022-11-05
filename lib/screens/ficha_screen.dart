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
  String _searchText = '';
  late Future<List<Ficha>> _listadoFicha;
  DateTime? _searchFechaDesde;
  DateTime? _searchFechaHasta;

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
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //Agregamos un inputfield que actualiza un valor a _searchText
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Buscar ficha',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: ((value) => {
                        setState(
                          (() => {_searchText = value}),
                        )
                      }),
                ),
                const SizedBox(height: 10),
                DateTimeFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Fecha desde',
                    labelText: 'Fecha desde',
                    icon: Icon(Icons.date_range),
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  onDateSelected: (DateTime value) {
                    setState(
                      (()  => {_searchFechaDesde = value})
                    );
                  },
                ),
                const SizedBox(height: 10),
                DateTimeFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Fecha hasta',
                    labelText: 'Fecha hasta',
                    icon: Icon(Icons.date_range),
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  onDateSelected: (DateTime value) {
                    setState(
                      (()  => {_searchFechaHasta = value})
                    );
                  },
                ),
              ],
            ),
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
                if (_searchText == '' &&
                    _searchFechaDesde == null &&
                    _searchFechaHasta == null) {
                  return CustomFichaCard(
                    idFichaClinica: snapshot.data![index].idFichaClinica,
                    fechaHora: snapshot.data![index].fechaHora,
                    motivoConsulta: snapshot.data![index].motivoConsulta,
                    diagnostico: snapshot.data![index].diagnostico,
                    observacion: snapshot.data![index].observacion,
                    idLocal: snapshot.data![index].idLocal,
                    idEmpleado: snapshot.data![index].idEmpleado,
                    nombreEmpleado: snapshot.data![index].nombreEmpleado,
                    apellidoEmpleado: snapshot.data![index].apellidoEmpleado,
                    idCliente: snapshot.data![index].idCliente,
                    nombreCliente: snapshot.data![index].nombreCliente,
                    apellidoCliente: snapshot.data![index].apellidoCliente,
                    idTipoProducto: snapshot.data![index].idTipoProducto,
                    fechaHoraCadena: snapshot.data![index].fechaHoraCadena,
                    fechaHoraCadenaFormateada: snapshot.data![index].fechaHoraCadenaFormateada,
                    fechaDesdeCadena: snapshot.data![index].fechaDesdeCadena,
                    fechaHastaCadena: snapshot.data![index].fechaHastaCadena,
                    todosLosCampos: snapshot.data![index].todosLosCampos,
                  );
                } else {
                  DateTime fechaHora = DateTime.parse(snapshot.data![index].fechaHora!);
                  bool flagTexto = _searchText == "" || (
                                  (snapshot.data![index].nombreEmpleado!.toLowerCase().contains(_searchText.toLowerCase())) ||
                                  (snapshot.data![index].apellidoEmpleado != null && snapshot.data![index].apellidoEmpleado!.toLowerCase().contains(_searchText.toLowerCase())) ||
                                  (snapshot.data![index].nombreCliente!.toLowerCase().contains(_searchText.toLowerCase())) ||
                                  (snapshot.data![index].apellidoCliente != null && snapshot.data![index].apellidoCliente!.toLowerCase().contains(_searchText.toLowerCase())));

                  bool flagDesde = _searchFechaDesde == null || (_searchFechaDesde!= null && fechaHora.isAfter(_searchFechaDesde!));
                  bool flagHasta = _searchFechaHasta == null || (_searchFechaHasta!= null && fechaHora.isBefore(_searchFechaHasta!));
                  if (flagTexto && flagDesde && flagHasta)
                  {
                    return CustomFichaCard(
                      idFichaClinica: snapshot.data![index].idFichaClinica,
                      fechaHora: snapshot.data![index].fechaHora,
                      motivoConsulta: snapshot.data![index].motivoConsulta,
                      diagnostico: snapshot.data![index].diagnostico,
                      observacion: snapshot.data![index].observacion,
                      idLocal: snapshot.data![index].idLocal,
                      idEmpleado: snapshot.data![index].idEmpleado,
                      nombreEmpleado: snapshot.data![index].nombreEmpleado,
                      apellidoEmpleado: snapshot.data![index].apellidoEmpleado,
                      idCliente: snapshot.data![index].idCliente,
                      nombreCliente: snapshot.data![index].nombreCliente,
                      apellidoCliente: snapshot.data![index].apellidoCliente,
                      idTipoProducto: snapshot.data![index].idTipoProducto,
                      fechaHoraCadena: snapshot.data![index].fechaHoraCadena,
                      fechaHoraCadenaFormateada: snapshot.data![index].fechaHoraCadenaFormateada,
                      fechaDesdeCadena: snapshot.data![index].fechaDesdeCadena,
                      fechaHastaCadena: snapshot.data![index].fechaHastaCadena,
                      todosLosCampos: snapshot.data![index].todosLosCampos,
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
