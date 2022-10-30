import 'package:flutter/material.dart';
import 'package:project_frontend_2/models/models.dart';

import '../screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'home';

  //Aqui dentro agregamos las opciones del menu
  static final menuOptions = <MenuOption>[
    //Este es un ejemplo de como usar el menu opcion con la lista de pacientes
    const MenuOption(
      name: 'Pacientes',
      icon: Icons.person,
      route: 'pacientes',
      screen: PacienteScreen(),
    ),
    const MenuOption(
      name: 'Recerva de turno',
      icon: Icons.calendar_today_sharp,
      route: 'reserva',
      screen: PacienteScreen(),
    ),
    const MenuOption(
      name: 'Ficha clinica',
      icon: Icons.description_outlined,
      route: 'ficha',
      screen: PacienteScreen(),
    ),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }
    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    );
  }
}
