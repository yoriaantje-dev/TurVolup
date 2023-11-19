import 'package:flutter/material.dart';

Future<bool> displayPINInputDialog(
  BuildContext context,
  TextEditingController textFieldController,
  String title,
  String hint,
) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          controller: textFieldController,
          decoration: InputDecoration(
            hintText: hint,
          ),
          keyboardType: TextInputType.number,
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Annuleren'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          ElevatedButton(
            child: const Text('Bevestigen'),
            onPressed: () {
              bool result = _checkPin(textFieldController.text, context);
              Navigator.pop(context, result);
            },
          ),
        ],
      );
    },
  );
}

bool _checkPin(String pin, BuildContext context) {
  if (pin.length != 4) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("PIN moet 4 cijfers bevatten"),
      ),
    );
    return false;
  } else if (pin == "1978") {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("De lijst is geleegd."),
      ),
    );
    return true;
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("PIN is incorrect"),
      ),
    );
    return false;
  }
}

Future<bool> displayTextInputDialog(
  BuildContext context,
  TextEditingController textFieldController,
  String title,
  String hint,
) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Column(
          children: [
            Text(hint),
            TextField(
              controller: textFieldController,
              decoration: InputDecoration(hintText: hint),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Annuleren'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          ElevatedButton(
            child: const Text('Bevestigen'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      );
    },
  );
}
