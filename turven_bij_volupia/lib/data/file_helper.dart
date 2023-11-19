import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:turven_bij_volupia/data/models/turving_collection_model.dart';
import 'data_helper.dart';
import 'models/turvable_item_model.dart';

class FileStorage {
  final filename = "participants";

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$filename.txt');
  }

  Future<String> readFileAsString() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      return "Read error: $e";
    }
  }

  Future<File> writeStringToFile(String content) async {
    final file = await _localFile;
    return file.writeAsString(content);
  }

  Future<List<TurvableItem>> loadItemsFromFile() async {
    String jsonString = await readFileAsString();
    List<TurvableItem> returnList = [];
    try {
      Map<String, dynamic> mappedJson = jsonDecode(jsonString);
      for (Map<String, dynamic> turvableItemMap in mappedJson["turvingList"]) {
        returnList.add(TurvableItem.fromJSON(turvableItemMap));
      }
      if (kDebugMode) print("Loaded from file.");
    } catch (e) {
      if (kDebugMode) print("Error: $e\n");
    }
    return returnList.removeDuplicates();
  }

  void saveTurvingListToFile(List<TurvableItem> incomingList,
      {bool reset = false}) async {
    if (reset) incomingList = TurvCollection.exampleCollection("Default").items;
    incomingList.removeDuplicates();

    List<Map<String, dynamic>> saveList = [];
    for (TurvableItem turvableItem in incomingList) {
      saveList.add(turvableItem.toMap());
    }

    Map<String, dynamic> saveMap = {"turvingList": saveList};
    writeStringToFile(jsonEncode(saveMap));
    if (kDebugMode) print("Saved to file.");
  }
}
