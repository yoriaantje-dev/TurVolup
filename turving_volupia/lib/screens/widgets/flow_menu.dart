import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

Widget floatingActionMenu(
    bool isDarkMode, dynamic addItemFunction, dynamic saveCollectionFunction) {
  return SpeedDial(
    overlayColor: isDarkMode ? Colors.grey[900] : Colors.grey[300],
    backgroundColor: isDarkMode ? Colors.red[600] : Colors.redAccent[200],
    foregroundColor: Colors.white,
    animatedIcon: AnimatedIcons.menu_close,
    children: [
      SpeedDialChild(
        backgroundColor: isDarkMode ? Colors.red[400] : Colors.red[200],
        foregroundColor: Colors.white,
        labelBackgroundColor: isDarkMode ? Colors.grey[600] : Colors.grey[200],
        child: const Icon(Icons.add),
        labelWidget: Container(
          decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[600] : Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(7))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Nieuw Turf item",
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
          ),
        ),
        onTap: addItemFunction,
      ),
      SpeedDialChild(
        backgroundColor: isDarkMode ? Colors.red[400] : Colors.red[200],
        foregroundColor: Colors.white,
        child: const Icon(Icons.save),
        labelWidget: Container(
          decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[600] : Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(7))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Opslaan",
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
          ),
        ),
        onTap: saveCollectionFunction,
      ),
    ],
  );
}
