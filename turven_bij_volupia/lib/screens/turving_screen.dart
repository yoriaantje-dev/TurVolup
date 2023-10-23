import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../shared/flow_menu.dart';

import '../data/file_helper.dart';
import '../data/models/turvable_item_model.dart';

class TurvingScreen extends StatefulWidget {
  const TurvingScreen({super.key, required this.storage});

  final FileStorage storage;

  @override
  State<TurvingScreen> createState() => _TurvingScreenState();
}

class _TurvingScreenState extends State<TurvingScreen>
    with WidgetsBindingObserver {
  List<TurvableItem> turvingItemList = [];

  List<TurvableItem> _makeDefaultList() {
    return [
      TurvableItem("Bier", 1),
      TurvableItem("Wijn", 1.5),
      TurvableItem("Fris", 1),
    ];
  }

  void _removeDuplicateItems() {
    final nameSet = <String>{};
    final noDuplicateList = <TurvableItem>[];
    for (final turvableItem in turvingItemList) {
      if (nameSet.add(turvableItem.name.trim().toLowerCase())) {
        noDuplicateList.add(turvableItem);
      }
    }
    setState(() {
      turvingItemList = noDuplicateList;
    });
  }

  //#region CRUD
  void _loadFromFile({bool reset = false}) async {
    String jsonString = await widget.storage.readFileAsString();
    try {
      Map<String, dynamic> mappedJson = jsonDecode(jsonString);
      for (Map<String, dynamic> turvableItemMap in mappedJson["turvingList"]) {
        setState(() {
          turvingItemList.add(TurvableItem.fromJSON(turvableItemMap));
        });
      }
    } catch (e) {
      setState(() {
        turvingItemList = _makeDefaultList();
      });
      if (kDebugMode) print("Error: $e\n" "Loaded from defaults.");
    }

    if (turvingItemList.isEmpty || reset) {
      // if (reset) {
      setState(() {
        turvingItemList = _makeDefaultList();
      });
    } else if (kDebugMode) {
      print("Loaded from file.");
    }
  }

  void _saveList({bool reset = false}) async {
    if (reset) {
      setState(() {
        turvingItemList = _makeDefaultList();
      });
    }
    _removeDuplicateItems();

    List<Map<String, dynamic>> saveList = [];
    for (TurvableItem turvableItem in turvingItemList) {
      saveList.add(turvableItem.toMap());
    }
    Map<String, dynamic> saveMap = {"turvingList": saveList};
    widget.storage.writeFile(jsonEncode(saveMap));
    if (kDebugMode) print("Saved to file.");
  }

  void _deleteList() {
    setState(() {
      turvingItemList = [];
    });
    _saveList();
  }
  //#endregion

  void removeParticipantAtIndex(int index) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Verwijder ${turvingItemList[index].name}"),
          content: Text(
              "Weet je zeker dat je '${turvingItemList[index].name}' wilt verwijderen?"),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuleren'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            ElevatedButton(
              child: const Text('Ja'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmed) {
      setState(() {
        turvingItemList.removeAt(index);
      });
      _saveList();
    }
  }

  void functionAddTurvableItem(String input) async {
    if (input.isNotEmpty) {
      setState(() {
        turvingItemList.add(TurvableItem.fromCommaSeperatedString(input));
      });
      _removeDuplicateItems();
      _saveList();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (turvingItemList.isEmpty) {
      _loadFromFile(reset: false);
    } else {
      _saveList(reset: false);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Aftekenlijst")),
      floatingActionButton: floatingActionMenu(
        context,
        _saveList,
        _deleteList,
        functionAddTurvableItem,
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: turvingItemList.length,
          itemBuilder: (BuildContext context, int index) {
            return turfItemCard(index);
          },
        ),
      ),
    );
  }

  Widget turfItemCard(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: Colors.redAccent,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  turvingItemList[index].name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5.75),
                    child: removeButton(index),
                  ),
                  Text(
                    turvingItemList[index].count.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3.75),
                    child: addButton(index),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconButton removeButton(int index) {
    return IconButton(
      onPressed: () {
        turvingItemList[index].remove();
        _saveList();
      },
      icon: const Icon(Icons.exposure_neg_1),
      color: Colors.white70,
      iconSize: 45,
    );
  }

  IconButton addButton(int index) {
    return IconButton(
      onPressed: () {
        turvingItemList[index].add();
        _saveList();
      },
      icon: const Icon(Icons.exposure_plus_1),
      color: Colors.white70,
      iconSize: 45,
    );
  }
}
