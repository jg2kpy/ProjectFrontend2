import 'package:flutter/material.dart';

import '../models/reserva.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_agenda_card.dart';

class SeleccionarAgendaScreen extends StatefulWidget {
  final List<Reserva> reservas;

  const SeleccionarAgendaScreen({
    Key? key,
    required this.reservas,
  }) : super(key: key);

  @override
  State<SeleccionarAgendaScreen> createState() =>
      _SeleccionarAgendaScreenState();
}

class _SeleccionarAgendaScreenState extends State<SeleccionarAgendaScreen> {
  String _searchText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Reserva'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //Agregamos un inputfield que actualiza un valor a _searchText
              children: [
                const Center(child: Text('Paso 2 de 3')),
                const SizedBox(height: 20),
                const LinearProgressIndicator(
                  value: 0.66,
                  minHeight: 5,
                  color: AppTheme.primary,
                ),
                const SizedBox(height: 10),
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
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.reservas.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_searchText == '') {
                    return CustomAgendaCard(
                      idReserva: widget.reservas[index].idReserva,
                      horaInicioCadena: widget.reservas[index].horaInicioCadena,
                      horaFinCadena: widget.reservas[index].horaFinCadena,
                      nombreCliente: widget.reservas[index].nombreCliente,
                      apellidoCliente: widget.reservas[index].apellidoCliente,
                      idCliente: widget.reservas[index].idCliente,
                      idEmpleado: widget.reservas[index].idEmpleado,
                      fechaCadena: widget.reservas[index].fechaCadena,
                    );
                  } else {
                    if (widget.reservas[index].nombreCliente!
                            .toLowerCase()
                            .contains(_searchText.toLowerCase()) ||
                        widget.reservas[index].apellidoCliente!
                            .toLowerCase()
                            .contains(_searchText.toLowerCase())) {
                      return CustomAgendaCard(
                        idReserva: widget.reservas[index].idReserva,
                        horaInicioCadena:
                            widget.reservas[index].horaInicioCadena,
                        horaFinCadena: widget.reservas[index].horaFinCadena,
                        nombreCliente: widget.reservas[index].nombreCliente,
                        apellidoCliente: widget.reservas[index].apellidoCliente,
                        idCliente: widget.reservas[index].idCliente,
                        idEmpleado: widget.reservas[index].idEmpleado,
                        fechaCadena: widget.reservas[index].fechaCadena,
                      );
                    } else {
                      return Container();
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
