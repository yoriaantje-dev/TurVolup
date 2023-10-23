import 'package:flutter/foundation.dart';

class TurvableItem {
  String name = "DRANKJE";
  double cost = 1;
  int count = 0;

  TurvableItem(this.name, this.cost);

  TurvableItem.fromCommaSeperatedString(String commaSeperatedString) {
    List<String> itemAsList = commaSeperatedString.split(",");
    String csvName = itemAsList[0];
    double csvCost = double.tryParse(itemAsList[1]) ?? 1;
    int csvCount = int.tryParse(itemAsList[2]) ?? 0;

    name = csvName;
    cost = csvCost;
    count = csvCount;
  }

  TurvableItem.fromJSON(Map<String, dynamic> turvableItemMap) {
    name = turvableItemMap["name"] ?? "INGELADEN DRANKJE";
    cost = turvableItemMap["cost"] ?? 1;
    count = turvableItemMap["count"] ?? 0;
  }

  Map<String, dynamic> toMap() {
    return {"name": name, "cost": cost, "count": count};
  }

  void add({int amount = 1}) {
    count += amount;
    if (kDebugMode) {
      print("Added $amount to $name: $count");
    }
  }

  void remove({int amount = 1}) {
    count -= amount;
    if (count < 0) count = 0;
    if (kDebugMode) {
      print("Removed $amount from $name: $count");
    }
  }

  void set(int amount) {
    count == amount;
    if (kDebugMode) {
      print("Set $amount in $name");
    }
  }
}
