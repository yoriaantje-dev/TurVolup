import 'package:flutter/material.dart';

import '../shared/drawer.dart';
import '../data/data_helper.dart';
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

  void setList(List<TurvableItem> incomingList) {
    setState(() {
      turvingItemList = incomingList;
    });
  }

  List<TurvableItem> getList() => turvingItemList;

  @override
  Widget build(BuildContext context) {
    if (turvingItemList.isEmpty) {
      widget.storage.loadItemsFromFile().then((value) => setList(value));
    } else {
      widget.storage.saveTurvingListToFile(turvingItemList);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Aftekenlijst")),
      drawer: MenuDrawer(
        functionAddItem: turvingItemList.functionAddTurvableItem,
        functionSave: widget.storage.saveTurvingListToFile,
        functionSetList: setList,
        functionGetList: getList,
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
      child: GestureDetector(
        onLongPress: () {
          turvingItemList[index].remove();
          setList(turvingItemList);
          widget.storage.saveTurvingListToFile(turvingItemList);
        },
        onTap: () {
          turvingItemList[index].add();
          setList(turvingItemList);
          widget.storage.saveTurvingListToFile(turvingItemList);
        },
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
                      fontSize: 28.25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Text(
                      turvingItemList[index].count.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3.25),
                      child: _addButton(index),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconButton _removeButton(int index) {
    return IconButton(
      onPressed: () {
        turvingItemList[index].remove();
        setList(turvingItemList);
        widget.storage.saveTurvingListToFile(turvingItemList);
      },
      icon: const Icon(Icons.exposure_neg_1),
      color: Colors.white70,
      iconSize: 45,
    );
  }

  IconButton _addButton(int index) {
    return IconButton(
      onPressed: () {
        turvingItemList[index].add();
        setList(turvingItemList);
        widget.storage.saveTurvingListToFile(turvingItemList);
      },
      icon: const Icon(Icons.exposure_plus_1),
      color: Colors.white70,
      iconSize: 45,
    );
  }
}
