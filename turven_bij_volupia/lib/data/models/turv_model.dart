// ignore_for_file: avoid_print
import 'dart:convert';

class TurvCollection {
  late String collectionId;
  late List<TurvableItem> items;

  TurvCollection(this.items, String prefix) {
    DateTime currentDate = DateTime.now();
    collectionId =
        "${prefix}_${currentDate.day}_${currentDate.month}_${currentDate.year}";
  }

  String createSaveString() {
    Map<String, dynamic> turfItemMap = {};

    for (TurvableItem turfItem in items) {
      turfItemMap[turfItem.name] = turfItem.saveItem();
    }

    Map<String, dynamic> saveMap = {"date": collectionId, "items": turfItemMap};
    String encoded = jsonEncode(saveMap);
    return encoded;
  }

  TurvCollection.exampleCollection(String prefix) {
    items = [
      TurvableItem("Bier", 1),
      TurvableItem("Wijn", 1.5),
      TurvableItem("Fris", 1),
    ];
    DateTime currentDate = DateTime.now();
    collectionId =
        "${prefix}_${currentDate.day}_${currentDate.month}_${currentDate.year}";
  }

  TurvCollection.fromJSON(Map<String, dynamic> collectionMap) {
    collectionId = collectionMap["date"] ?? "ERROR";
    Map<String, dynamic> subMap = collectionMap["items"] ?? {};
    List<TurvableItem> tempList = [];
    for (String key in subMap.keys) {
      tempList.add(TurvableItem.fromJSON(key, subMap[key]));
    }
    items = tempList;
  }
}

class TurvableItem {
  String name;
  double cost = 1;
  int count = 0;

  TurvableItem(this.name, this.cost);

  TurvableItem.fromJSON(this.name, Map<String, dynamic> item) {
    cost = item["cost"] ?? 1;
    count = item["count"] ?? 0;
  }

  Map<String, dynamic> saveItem() {
    return {"cost": cost, "count": count};
  }

  void add(int amount) {
    count += amount;
    print("Added $amount to $name: $count");
  }

  void remove(int amount) {
    count -= amount;
    if (count < 0) count = 0;
    print("Removed $amount from $name: $count");
  }

  void set(int amount) {
    count == amount;
    print("Set $amount in $name");
  }
}
