import 'package:flutter/material.dart';
import 'package:project_frontend_2/models/models.dart';
import 'package:project_frontend_2/routes/reserva_routes.dart';
import 'package:project_frontend_2/screens/reserva_screen.dart';

import '../screens/screens.dart';
import 'pacientes_routes.dart';
import 'ficha_routes.dart';

class AppRoutes {
  static const initialRoute = 'login';

  //Aqui dentro agregamos las opciones del menu
  static final menuOptions = <MenuOption>[
    const MenuOption(
      name: 'Pacientes',
      icon: Icons.person,
      route: 'pacientes',
      screen: PacienteScreen(),
    ),
    const MenuOption(
      name: 'Reserva de turno',
      icon: Icons.calendar_today_sharp,
      route: 'reserva',
      screen: ReservaScreen(),
    ),
    const MenuOption(
      name: 'Ficha clinica',
      icon: Icons.description_outlined,
      route: 'ficha',
      screen: FichaScreen(),
    ),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    //Agregamos todas las rutas para la pantalla de pacientes
    for (final option in PacientesRoutes.rutas) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    for (final option in ReservasRoutes.rutas) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    for (final option in FichaRoutes.rutas) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    //Agregamos la pantalla de home como una ruta
    appRoutes.addAll({'home': (BuildContext context) => const HomeScreen()});

    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    );
  }
}
