// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// Disabled for Release v0.0.1
// ignore: unused_import
import '../shared/menu_drawer.dart';
import '../shared/popup_dialog.dart';
import '../data/models/turv_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TurvCollection collection = TurvCollection.exampleCollection();

  void _addTurvableItem() async {
    final item = await showDialog<TurvableItem>(
      context: context,
      builder: (context) => const AddTurvableItemDialog(),
    );
    if (item != null) {
      setState(() {
        collection.items.add(item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      // Disabled for Release v0.0.1
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: collection.items.length,
              itemBuilder: (BuildContext context, int index) {
                return turvItemCard(collection.items[index]);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton(
          onPressed: _addTurvableItem,
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.redAccent)),
          child: const Text(
            "VOEG TURF ITEM TOE",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget turvItemCard(TurvableItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                    color: Colors.white,
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
                    color: Colors.white,
                    iconSize: 25,
                  ),
                  Text(
                    item.count.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        item.add(1);
                      });
                    },
                    icon: const Icon(Icons.exposure_plus_1),
                    color: Colors.white,
                    iconSize: 25,
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
