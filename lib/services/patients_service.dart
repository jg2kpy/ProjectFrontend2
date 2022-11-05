import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_frontend_2/models/models.dart';

class PatientsService {
  static String url = 'equipoyosh.com';

  static Future<List<Paciente>> getPacientes() async {
    List<Paciente> listaPacientes = [];

    Uri uri = Uri.http(url, '/stock-nutrinatalia/persona');

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var item in data['lista']) {
        listaPacientes.add(Paciente(
          id: item["idPersona"],
          apellido: item["apellido"],
          cedula: item["cedula"],
          email: item["email"],
          fechaNacimiento: item["fechaNacimiento"],
          nombre: item["nombre"],
          ruc: item["ruc"],
          telefono: item["telefono"],
          tipoPersona: item["tipoPersona"],
        ));
      }
      return listaPacientes;
    } else {
      throw Exception('Error al obtener los pacientes');
    }
  }

  static Future<String> agregarPaciente(Map<String, String> formValues) async {
    Uri uri = Uri.https(url, '/stock-nutrinatalia/persona');

    print('JsonEncode');
    print(jsonEncode(formValues));

    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(formValues),
    );

    if (response.statusCode == 301 || response.statusCode == 201) {
      print(response.statusCode);
      return 'OK';
    } else {
      print(response.body);
      print(response.statusCode);
      throw Exception('Error');
    }
  }
}
