import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/models/turv_model.dart';

class AddTurvableItemDialog extends StatefulWidget {
  const AddTurvableItemDialog({super.key});

  @override
  State<AddTurvableItemDialog> createState() => _AddTurvableItemDialogState();
}

class _AddTurvableItemDialogState extends State<AddTurvableItemDialog> {
  final _nameController = TextEditingController();
  final _costController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _costController.dispose();
    super.dispose();
  }

  void _onSavePressed(BuildContext context) {
    final name = _nameController.text.trim();
    final cost = double.tryParse(_costController.text.trim()) ?? 0.0;

    if (name.isNotEmpty && cost > 0) {
      final item = TurvableItem(name, cost);
      Navigator.of(context).pop(item);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid name and cost"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a Turvable Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Enter name'),
          ),
          TextField(
            controller: _costController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
            decoration: const InputDecoration(hintText: 'Enter cost'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: const Text('SAVE'),
          onPressed: () {
            _onSavePressed(context);
          },
        ),
      ],
    );
  }
}
