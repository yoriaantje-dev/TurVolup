import 'package:flutter/material.dart';

import '../shared/menu_drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Data export")),
      drawer: const MenuDrawer(),
      body: const Placeholder(),
    );
  }
}
