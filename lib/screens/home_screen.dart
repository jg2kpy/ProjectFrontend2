import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pantalla principal'),
        ),
        body: const Center(
          child: Text('Pantalla pdarincipal'),
        ),
      ),
    );
  }
}
