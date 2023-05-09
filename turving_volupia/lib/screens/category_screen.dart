import 'package:flutter/material.dart';

import '../shared/menu_drawer.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categorieën")),
      drawer: const MenuDrawer(),
      body: const Placeholder(),
    );
  }
}
