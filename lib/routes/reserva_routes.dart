import 'package:flutter/material.dart';
import 'package:project_frontend_2/models/models.dart';
import '../screens/screens.dart';
// Creamos un Map donde colocamos todas las rutas que requiere la pantalla de pacientes

// Ejemplo de como definir rutas especifica para una pantalla especifica
class ReservasRoutes {
  static final rutas = <MenuOption>[
    const MenuOption(
      name: 'Actualizar Reserva',
      icon: Icons.person_add,
      route: 'ActualizarReserva',
      screen: ActualizarReservaScreen(),
    ),
  ];
}
