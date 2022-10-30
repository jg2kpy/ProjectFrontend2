import 'package:flutter/material.dart';
import 'package:project_frontend_2/models/models.dart';

import '../screens/home_screen.dart';

class AppRoutes {
  static const initialRoute = 'home';

  //Aqui dentro agregamos las opciones del menu
  static final menuOptions = <MenuOption>[];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }
    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => HomeScreen(),
    );
  }
}
