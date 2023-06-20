import 'package:flutter/material.dart';

import '../shared/menu_drawer.dart';

class DefaultItemScreen extends StatelessWidget {
  const DefaultItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Standaard turf items")),
      drawer: const MenuDrawer(),
      body: const Placeholder(),
    );
  }
}
