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
          nombreEmpleado: item["idEmpleado"]["nombre"],
          apellidoEmpleado: item["idEmpleado"]["apellido"],
          idCliente: item["idCliente"]["idPersona"],
          nombreCliente: item["idCliente"]["nombre"],
          apellidoCliente: item["idCliente"]["apellido"],
          observacion: item["observacion"],
          flagAsistio: item["flagAsistio"],
          fechaDesdeCadena: item["fechaDesdeCadena"],
          fechaHastaCadena: item["fechaHastaCadena"],
        ));
      }
      return listaFicha;
    } else {
      throw Exception('Error al obtener las reservas');
    }
  }

  static Future<String> agregarReserva(Map<String, String> formValues) async {
    Uri uri = Uri.https(url, '/stock-nutrinatalia/reserva');
    int? idEmpleado = int.parse(formValues['idEmpleado']!);
    int? idCliente = int.parse(formValues['idCliente']!);
    var horaInicioCadena = formValues['horaInicioCadena'];
    var horaFinCadena = formValues['horaFinCadena'];
    var formFinal = {
      'idEmpleado': {'idPersona': idEmpleado},
      'idCliente': {'idPersona': idCliente},
      'fechaCadena': formValues['fechaCadena'],
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
      throw Exception('Error');
    }
  }

  static Future<String> actualizarReserva(
      Map<String, String> formValues) async {
    Uri uri = Uri.https(url, '/stock-nutrinatalia/reserva');

    int? idReserva = int.parse(formValues['ID']!);
    var formFinal = {
      'idReserva': idReserva,
      'observacion': formValues['observacion'],
      'flagAsistio': formValues['flagAsistio'],
    };

    final response = await http.put(
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
      throw Exception('Error');
    }
  }

  static Future<String> cancelarReserva(int? id) async {
    Uri uri = Uri.https(url, '/stock-nutrinatalia/reserva/$id');

    final response = await http.delete(
      uri,
      headers: <String, String>{
        'usuario': 'usuario1',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 301 ||
        response.statusCode == 201 ||
        response.statusCode == 200) {
      return 'OK';
    } else {
      throw Exception('Error');
    }
  }

  static Future<List<Reserva>> getReservasByDateAndDoctor(
      Map<String, String> formValue) async {
    List<Reserva> listaReservas = [];

    String? fechaEdit = formValue['fechaCadena']!.split(' ')[0];
    fechaEdit = fechaEdit.replaceAll('-', '');

    Uri uri = Uri.http(url,
        '/stock-nutrinatalia/persona/${formValue['idDoctor']}/agenda?fecha=$fechaEdit');

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var item in data) {
        listaReservas.add(
          Reserva(
            idReserva: item["idReserva"],
            fechaCadena: item["fechaCadena"],
            fecha: item["fecha"],
            horaInicioCadena: item["horaInicioCadena"],
            horaFinCadena: item["horaFinCadena"],
            idEmpleado: item["idEmpleado"]["idPersona"],
            nombreEmpleado:
                item["idEmpleado"] != null ? item["idEmpleado"]["nombre"] : '',
            apellidoEmpleado: item["idEmpleado"] != null
                ? item["idEmpleado"]["apellido"]
                : '',
            idCliente:
                item["idCliente"] != null ? item["idCliente"]["idPersona"] : 0,
            nombreCliente:
                item["idCliente"] != null ? item["idCliente"]["nombre"] : '',
            apellidoCliente:
                item["idCliente"] != null ? item["idCliente"]["apellido"] : '',
            observacion: item["observacion"],
            flagAsistio: item["flagAsistio"],
            fechaDesdeCadena: item["fechaDesdeCadena"],
            fechaHastaCadena: item["fechaHastaCadena"],
          ),
        );
      }
      return listaReservas;
    } else {
      throw Exception('Error al obtener las reservas');
    }
  }
}
