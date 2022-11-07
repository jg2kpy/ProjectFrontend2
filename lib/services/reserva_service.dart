import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_frontend_2/models/reserva.dart';

class ReservaService {
  static String url = 'equipoyosh.com';

  static Future<List<Reserva>> getReservas() async {
    List<Reserva> listaFicha = [];

    Uri uri = Uri.http(url, '/stock-nutrinatalia/reserva');

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var item in data['lista']) {
        listaFicha.add(Reserva(
          idReserva: item["idReserva"],
          fechaCadena: item["fechaCadena"],
          fecha: item["fecha"],
          horaInicioCadena: item["horaInicioCadena"],
          horaFinCadena: item["horaFinCadena"],
          idEmpleado: item["idEmpleado"]["idPersona"],
          nombreEmpleado: item["idCliente"]["nombre"],
          apellidoEmpleado: item["idCliente"]["apellido"],
          idCliente: item["idCliente"]["idPersona"],
          nombreCliente: item["idCliente"]["nombre"],
          apellidoCliente: item["idCliente"]["apellido"],
          observacion: item["observacion"],
          flagAsistio: item["flagAsistio"],
          fechaDesdeCadena: item["fechaDesdeCadena"],
          fechaHastaCadena: item["fechaHastaCadena"],
        ));
        print(item["fechaDesdeCadena"]);
      }
      return listaFicha;
    } else {
      throw Exception('Error al obtener las reservas');
    }
  }

  static Future<String> agregarReserva(Map<String, String> formValues) async {
    Uri uri = Uri.https(url, '/stock-nutrinatalia/reserva');
    String? fechaEdit = formValues['fechaCadena']!.split(' ')[0];
    fechaEdit = fechaEdit.replaceAll('-', '');
    int? idEmpleado = int.parse(formValues['idEmpleado']!);
    int? idCliente = int.parse(formValues['idEmpleado']!);
    var fechaCadena = fechaEdit;
    var horaInicioCadena = formValues['horaInicioCadena'];
    var horaFinCadena = formValues['horaFinCadena'];
    var formFinal = {
      'idEmpleado': idEmpleado,
      'idCliente': idCliente,
      'fechaCadena': fechaCadena,
      'horaInicioCadena': horaInicioCadena,
      'horaFinCadena': horaFinCadena,
    };
    final response = await http.post(
      uri,
      headers: <String, String>{
        'usuario': 'usuario1',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(formFinal),
    );

    if (response.statusCode == 301 ||
        response.statusCode == 201 ||
        response.statusCode == 200) {
      return 'OK';
    } else {
      print("------------------------------ a ${response.body}");
      throw Exception('Error');
    }
  }
}
