// ignore_for_file: avoid_print

class TurvCollection {
  List<TurvableItem> items = [];

  TurvCollection(this.items);

  TurvCollection.exampleCollection() {
    items = [
      TurvableItem("Bier", 1),
      TurvableItem("Wijn", 1.5),
      TurvableItem("Fris", 1),
    ];
  }
}

class TurvableItem {
  String name;
  double cost;
  int count = 0;

  TurvableItem(this.name, this.cost);

  void add(int amount) {
    count += amount;
    print("Added $amount to $name: $count");
  }

  void remove(int amount) {
    count -= amount;
    if (count < 0) count = 0;
    print("Removed $amount from $name: $count");
  }

  void set(int amount){
    count == amount;
    print("Set $amount in $name");
  }
}
