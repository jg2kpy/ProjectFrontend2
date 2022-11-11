import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_frontend_2/models/models.dart';

class FichaService {
  static String url = 'equipoyosh.com';

  static Future<List<Ficha>> getFichas() async {
    List<Ficha> listaFicha = [];

    Uri uri = Uri.http(url, '/stock-nutrinatalia/fichaClinica');

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var item in data['lista']) {
        listaFicha.add(Ficha(
          idFichaClinica: item["idFichaClinica"],
          fechaHora: item["fechaHora"],
          motivoConsulta: item["motivoConsulta"],
          diagnostico: item["diagnostico"],
          observacion: item["observacion"],
          idLocal: item["idLocal"]["idLocal"],
          idEmpleado: item["idEmpleado"]["idPersona"],
          nombreEmpleado: item["idEmpleado"]["nombre"],
          apellidoEmpleado: item["idEmpleado"]["apellido"],
          idCliente: item["idCliente"]["idPersona"],
          nombreCliente: item["idCliente"]["nombre"],
          apellidoCliente: item["idCliente"]["apellido"],
          idTipoProducto: item["idTipoProducto"]["idTipoProducto"],
          idCategoria: item["idTipoProducto"]["idCategoria"]["idCategoria"],
          fechaHoraCadena: item["fechaHoraCadena"],
          fechaHoraCadenaFormateada: item["fechaHoraCadenaFormateada"],
          fechaDesdeCadena: item["fechaDesdeCadena"],
          fechaHastaCadena: item["fechaHastaCadena"],
          todosLosCampos: item["todosLosCampos"],
        ));
      }
      return listaFicha;
    } else {
      throw Exception('Error al obtener las fichas clinicas');
    }
  }

  static Future<String> agregarFicha(Map<String, String> formValues) async {
    Uri uri = Uri.https(url, '/stock-nutrinatalia/fichaClinica');

    int? idEmpleado = int.parse(formValues['idEmpleado']!);
    int? idCliente = int.parse(formValues['idCliente']!);
    int? idTipoProducto = int.parse(formValues['idTipoProducto']!);
    var formFinal = {
      'motivoConsulta': formValues['motivoConsulta'],
      'diagnostico': formValues['diagnostico'],
      'observacion': formValues['observacion'],
      'idEmpleado': {
        'idPersona': idEmpleado
      },
      'idCliente': {
        'idPersona': idCliente,
      },
      'idTipoProducto': {
        'idTipoProducto': idTipoProducto,
      }
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
      print(response.statusCode);
      throw Exception('Error');
    }
  }

  static Future<String> editarFicha(Map<String, String> formValues) async {
    Uri uri = Uri.https(url, '/stock-nutrinatalia/fichaClinica');

    int? idFichaClinica = int.parse(formValues['idFichaClinica']!);
    var formFinal = {
      'idFichaClinica': idFichaClinica,
      'observacion': formValues['observacion'],
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
      print("------------------------------ a ${response.body}");
      print(response.statusCode);
      throw Exception('Error');
    }
  }
}
