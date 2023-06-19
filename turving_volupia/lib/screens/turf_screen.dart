import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../data/file_helper.dart';
import '../data/models/turv_model.dart';
import '../shared/menu_drawer.dart';
import '../shared/popup_dialog.dart';
import 'widgets/turf_item.dart';

class TurfScreen extends StatefulWidget {
  const TurfScreen(this.file, this.prefix, {super.key});
  final File? file;
  final String prefix;

  @override
  State<TurfScreen> createState() => _TurfScreenState();
}

class _TurfScreenState extends State<TurfScreen> {
  TurvCollection? collection;
  FileHelper helper = FileHelper();

  void _addTurvableItem() async {
    final item = await showDialog<TurvableItem>(
      context: context,
      builder: (context) => const AddTurvableItemDialog(),
    );
    if (item != null) {
      setState(() {
        collection!.items.add(item);
      });
    }
  }

  void _saveTurfCollection() async {
    List<TurvableItem> saveList = [];
    for (TurvableItem item in collection!.items) {
      saveList.add(item);
    }
    collection!.items = saveList;
    helper.saveCollection(collection!);
  }

  void addOne(int index) {
    setState(() {
      collection!.items[index].add(1);
    });
  }

  void removeOne(int index) {
    setState(() {
      collection!.items[index].remove(1);
    });
  }

  Future<TurvCollection> loadFromFile() async {
    String jsonString = await helper.readFromFile(widget.file!);
    Map<String, dynamic> mappedJson = jsonDecode(jsonString);
    TurvCollection returnThis = TurvCollection.fromJSON(mappedJson);
    return returnThis;
  }

  @override
  Widget build(BuildContext context) {
  collection ??= TurvCollection.exampleCollection(widget.prefix);

    return Scaffold(
      appBar: AppBar(title: const Text("Turf")),
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: collection!.items.length,
          itemBuilder: (BuildContext context, int index) {
            return TurfItemCard(
              item: collection!.items[index],
              addOne: () {
                addOne(index);
              },
              removeOne: () {
                removeOne(index);
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: _addTurvableItem,
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.redAccent)),
              child: const Text(
                "ADD",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                TurvCollection loadedCollection = await loadFromFile();
                setState(() {
                  collection = loadedCollection;
                });
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.redAccent)),
              child: const Text(
                "LOAD",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: _saveTurfCollection,
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.redAccent)),
              child: const Text(
                "SAVE",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
