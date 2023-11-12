import 'package:flutter/material.dart';
import 'package:turven_bij_volupia/main.dart';

import 'popup_dialog.dart';

// Add Drink text
const String addDrinkTitle = "Drankje toevoegen";
const String addDrinkDescription = """
Format: Naam,Kosten,StartAantal\n
Het start aantal is optioneel. De kosten zijn standaard 1 munt.\n
Geef streepje op om deze waardes over te slaan:
  Voorbeeld: Bier,-,-
  Kosten:    Wijn,1.5,-
  Aantal:    Fris,-,3
""";

class MenuDrawer extends StatelessWidget {
  final Function(String) functionAddItem;
  final Function functionSave;
  final Function functionDelete;

  const MenuDrawer({
    Key? key,
    required this.functionAddItem,
    required this.functionSave,
    required this.functionDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController textFieldController = TextEditingController();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.isDarkMode ? Colors.red[700] : Colors.red[200],
            ),
            child: Center(
              child: Image.asset(
                "assets/VolupiaLogo_WIT.png",
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          ListTile(
            title: const Text('Add Item', style: TextStyle(fontSize: 25),),
            trailing: Icon(
              Icons.add,
              color: context.isDarkMode ? Colors.red[400] : Colors.red[200],
              size: 35,
            ),
            onTap: () {
              displayTextInputDialog(context, textFieldController,
                      addDrinkTitle, addDrinkDescription)
                  .then((confirmed) {
                if (confirmed) {
                  functionAddItem(textFieldController.text);
                }
                Navigator.pop(context);
              });
            },
          ),
          ListTile(
            title: const Text('Save All', style: TextStyle(fontSize: 25),),
            trailing: Icon(
              Icons.save,
              color: context.isDarkMode ? Colors.red[400] : Colors.red[200],
              size: 35,
            ),
            onTap: () {
              functionSave();
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Delete All', style: TextStyle(fontSize: 25),),
            trailing: Icon(Icons.delete,
              color: context.isDarkMode ? Colors.red[400] : Colors.red[200],
              size: 35,
            ),
            onTap: () {
              functionDelete();
              Navigator.pop(context);
            },
          ),
          // Add more ListTile widgets for additional menu items
        ],
      ),
    );
  }
}
