import 'package:flutter/material.dart';

import '../data/models/turv_model.dart';
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
      drawer: const MenuDrawer(),
      body: ListView.builder(
        itemCount: collection.items.length,
        itemBuilder: (BuildContext context, int index) {
          return turvItemCard(collection.items[index]);
        },
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
