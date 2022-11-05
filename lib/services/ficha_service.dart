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
          idCliente: item["idCliente"]["idPersona"],
          idTipoProducto: item["idTipoProducto"]["idTipoProducto"],
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
}
