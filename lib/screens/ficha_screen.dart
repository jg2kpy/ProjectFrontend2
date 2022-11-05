import 'package:flutter/material.dart';

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
        title: const Text('Ficha screeen'),
      ),
      body: FutureBuilder(
        future: _listadoFicha,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                int? aux = snapshot.data![index].idFichaClinica;
                return Text("$aux");
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
