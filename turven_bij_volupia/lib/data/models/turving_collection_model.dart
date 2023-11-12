import 'dart:convert';
import 'turvable_item_model.dart';

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
      turfItemMap[turfItem.name] = turfItem.toMap();
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
      TurvableItem("Mix-drank", 3),
      TurvableItem("Cocktails", 2.5),
      TurvableItem("Radler 0.0", 1.5),
      TurvableItem("Liefmans", 1.5),
      TurvableItem("Despo", 1.5),
      TurvableItem("Shot", 1),
    ];
    DateTime currentDate = DateTime.now();
    collectionId =
        "${prefix}_${currentDate.day}_${currentDate.month}_${currentDate.year}";
  }

  // TurvCollection.fromJSON(Map<String, dynamic> collectionMap) {
  //   collectionId = collectionMap["date"] ?? "ERROR";
  //   Map<String, dynamic> subMap = collectionMap["items"] ?? {};
  //   List<TurvableItem> tempList = [];
  //   for (String key in subMap.keys) {
  //     tempList.add(TurvableItem.fromJSON(key, subMap[key]));
  //   }
  //   items = tempList;
  // }
}