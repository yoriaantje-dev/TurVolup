import 'package:flutter/material.dart';

class MyDialog extends StatefulWidget {
  const MyDialog({super.key});

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter text'),
      content: TextField(
        autofocus: true,
        onChanged: (value) {
          setState(() {
            _text = value;
          });
        },
        decoration: const InputDecoration(hintText: 'Enter text here'),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(_text);
          },
        ),
      ],
    );
  }
}
