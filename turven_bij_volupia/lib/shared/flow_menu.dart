import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../main.dart';
import 'popup_dialog.dart';

Color? dialMainOverlayColor(bool isDarkMode) =>
    isDarkMode ? Colors.grey[900] : Colors.grey[300];
Color? dialMainBackgroundColor(bool isDarkMode) =>
    isDarkMode ? Colors.red[600] : Colors.redAccent[200];
Color? dialLabelBackgroundColor(bool isDarkMode) =>
    isDarkMode ? Colors.grey[600] : Colors.grey[200];
Color? dialButtonBackgroundColor(bool isDarkMode) =>
    isDarkMode ? Colors.red[400] : Colors.red[200];

// Add Drink text
const String addDrinkTitle = "Drankje toevoegen";
const String addDrinkDescription = """
  Naam,Kosten,StartAantal\n
  Het start aantal is optioneel. De kosten zijn standaard 1 munt.\n
  Geef streepje op om deze waardes over te slaan:\n
    Voorbeeld: Bier,-,-\n
    Kosten:    Wijn,1.5,-\n
    Aantal:    Fris,-,3
""";

Widget floatingActionMenu(
  BuildContext context,
  dynamic functionSave,
  dynamic functionDelete,
  dynamic functionAddItem,
) {
  final TextEditingController textFieldController = TextEditingController();

  return SpeedDial(
    icon: Icons.my_library_books_sharp,
    onPress: () async {
      bool confirmed = await displayTextInputDialog(
          context, textFieldController, addDrinkTitle, addDrinkDescription);
      if (confirmed) functionAddItem(textFieldController.text);
    },
    activeIcon: Icons.close_fullscreen_rounded,
    overlayColor: dialMainOverlayColor(context.isDarkMode),
    backgroundColor: dialMainBackgroundColor(context.isDarkMode),
    foregroundColor: Colors.white,
    children: [
      deleteWithConfirmation(context, functionDelete),
      saveManually(context, functionSave),
      SpeedDialChild(
        backgroundColor: dialButtonBackgroundColor(context.isDarkMode),
        foregroundColor: Colors.white,
        child: const Icon(Icons.person_add_alt_sharp),
        labelWidget: Container(
            decoration: BoxDecoration(
                color: dialLabelBackgroundColor(context.isDarkMode),
                borderRadius: const BorderRadius.all(Radius.circular(7))),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Voeg drankje toe",
                    style: TextStyle(
                        color: context.isDarkMode
                            ? Colors.white
                            : Colors.black)))),
        onTap: () async {
          bool confirmed = await displayTextInputDialog(
              context, textFieldController, addDrinkTitle, addDrinkDescription);
          if (confirmed) functionAddItem(textFieldController.text);
        },
      ),
    ],
  );
}

SpeedDialChild saveManually(BuildContext context, Function functionSave) {
  return SpeedDialChild(
    backgroundColor: dialButtonBackgroundColor(context.isDarkMode),
    foregroundColor: Colors.white,
    child: const Icon(Icons.save),
    labelWidget: Container(
      decoration: BoxDecoration(
          color: dialLabelBackgroundColor(context.isDarkMode),
          borderRadius: const BorderRadius.all(Radius.circular(7))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Opslaan",
          style: TextStyle(
              color: context.isDarkMode ? Colors.white : Colors.black),
        ),
      ),
    ),
    onTap: () => functionSave,
  );
}

SpeedDialChild deleteWithConfirmation(
    BuildContext context, Function functionDelete) {
  return SpeedDialChild(
    backgroundColor: dialButtonBackgroundColor(context.isDarkMode),
    foregroundColor: Colors.white,
    child: const Icon(Icons.delete),
    labelWidget: Container(
      decoration: BoxDecoration(
          color: dialLabelBackgroundColor(context.isDarkMode),
          borderRadius: const BorderRadius.all(Radius.circular(7))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Delete alles",
          style: TextStyle(
              color: context.isDarkMode ? Colors.white : Colors.black),
        ),
      ),
    ),
    onTap: () async {
      bool confirmed = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Verwijder iedereen"),
            content: const Text(
                "Bevestig dat je iedereen wilt verwijderen van de lijst."),
            actions: <Widget>[
              TextButton(
                child: const Text('Annuleren'),
                onPressed: () => Navigator.pop(context, false),
              ),
              ElevatedButton(
                child: const Text('Ja'),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          );
        },
      );
      if (confirmed) functionDelete();
    },
  );
}
