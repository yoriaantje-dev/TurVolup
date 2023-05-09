import 'package:flutter/material.dart';

import '../shared/menu_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      drawer: const MenuDrawer(),
      body: const Placeholder(),
    );
  }
}
