import 'package:flutter/material.dart';

import '../shared/menu_drawer.dart';

class TurfScreen extends StatelessWidget {
  const TurfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Turven")),
      drawer: const MenuDrawer(),
      body: const Placeholder(),
    );
  }
}
