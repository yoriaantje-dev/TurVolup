import 'package:flutter/material.dart';

import 'models/turvable_item_model.dart';

extension DataHelper on List<TurvableItem> {
  removeDuplicates() {
    final nameSet = <String>{};
    final noDuplicateList = <TurvableItem>[];
    for (final turvableItem in this) {
      if (nameSet.add(turvableItem.name.trim().toLowerCase())) {
        noDuplicateList.add(turvableItem);
      }
    }
    return noDuplicateList;
  }

  removeParticipantAtIndex(
      int index, BuildContext context, dynamic setList) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Verwijder ${this[index].name}"),
          content: Text(
              "Weet je zeker dat je '${this[index].name}' wilt verwijderen?"),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuleren'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            ElevatedButton(
              child: const Text('Ja'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmed) removeAt(index);
    setList(removeDuplicates());
  }

  functionAddTurvableItem(String input, dynamic setList) {
    if (input.isNotEmpty) add(TurvableItem.fromCommaSeperatedString(input));
    setList(removeDuplicates());
  }

  Widget createEveningResultString() {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          // Table Header
          const TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'Drankje',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'Aantal',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'Opbrengst',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Table Rows
          for (final turvableItem in this)
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      turvableItem.name,
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      '${turvableItem.count}st',
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      turvableItem.getTotalCostString(),
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
