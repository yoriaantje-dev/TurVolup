import 'package:flutter/material.dart';
import 'package:turven_bij_volupia/data/data_helper.dart';
import 'package:turven_bij_volupia/main.dart';

import '../data/models/turvable_item_model.dart';
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
  final Function(String, dynamic) functionAddItem;
  final Function(List<TurvableItem>) functionSave;
  final Function(List<TurvableItem> listToSet) functionSetList;
  final List<TurvableItem> Function() functionGetList;

  const MenuDrawer({
    super.key,
    required this.functionAddItem,
    required this.functionSave,
    required this.functionSetList,
    required this.functionGetList,
  });

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
            title: const Text(
              'Add Item',
              style: TextStyle(fontSize: 25),
            ),
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
                  functionAddItem(textFieldController.text, functionSetList);
                }
                Navigator.pop(context);
              });
            },
          ),
          ListTile(
            title: const Text(
              'Save All',
              style: TextStyle(fontSize: 25),
            ),
            trailing: Icon(
              Icons.save,
              color: context.isDarkMode ? Colors.red[400] : Colors.red[200],
              size: 35,
            ),
            onTap: () {
              functionSave(functionGetList());
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
              'Export data',
              style: TextStyle(fontSize: 25),
            ),
            trailing: Icon(
              Icons.ios_share,
              color: context.isDarkMode ? Colors.red[400] : Colors.red[200],
              size: 35,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog.fullscreen(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Resultaat van vanavond",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: functionGetList().createEveningResultString(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: ElevatedButton(
                            child: const Text(
                              'Sluiten',
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).then((value) => Navigator.pop(context));
            },
          ),
          ListTile(
            title: const Text(
              'Delete All',
              style: TextStyle(fontSize: 25),
            ),
            trailing: Icon(
              Icons.delete,
              color: context.isDarkMode ? Colors.red[400] : Colors.red[200],
              size: 35,
            ),
            onTap: () {
              displayPINInputDialog(
                context,
                textFieldController,
                "Geef de pincode op om de lijst te verwijderen",
                "PIN?",
              ).then((confirmed) {
                if (confirmed) {
                  functionSetList(
                    TurvCollection.exampleCollection("Default").items,
                  );
                  Navigator.pop(context);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
