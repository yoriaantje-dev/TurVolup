import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

Widget floatingActionMenu(
    dynamic addItemFunction, dynamic saveCollectionFunction) {
  return SpeedDial(
    overlayColor: Colors.grey[3],
    backgroundColor: Colors.redAccent,
    foregroundColor: Colors.white,
    animatedIcon: AnimatedIcons.menu_close,
    children: [
      SpeedDialChild(
        backgroundColor: Colors.deepOrange[200],
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        label: "Nieuw Turf item",
        onTap: addItemFunction,
      ),
      SpeedDialChild(
        backgroundColor: Colors.deepOrange[200],
        foregroundColor: Colors.white,
        child: const Icon(Icons.save),
        label: "Opslaan",
        onTap: saveCollectionFunction,
      ),
    ],
  );
}
