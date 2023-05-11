// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import '../data/models/turv_model.dart';

// Disabled for Release v0.0.1
// ignore: unused_import
import '../shared/menu_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TurvCollection collection = TurvCollection.exampleCollection();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      // Disabled for Release v0.0.1
      // drawer: const MenuDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: collection.items.length,
              itemBuilder: (BuildContext context, int index) {
                return turvItemCard(collection.items[index]);
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                print("Not Implemented yet!");
              },
              child: const Text("Add a category"))
        ],
      ),
    );
  }

  Widget turvItemCard(TurvableItem item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.redAccent,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        item.remove(1);
                      });
                    },
                    icon: const Icon(Icons.exposure_neg_1),
                  ),
                  Text(
                    item.count.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        item.add(1);
                      });
                    },
                    icon: const Icon(Icons.exposure_plus_1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
