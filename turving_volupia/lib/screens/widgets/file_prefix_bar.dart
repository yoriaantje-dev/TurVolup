import 'package:flutter/material.dart';

class FilePrefixBar extends StatelessWidget {
  const FilePrefixBar({
    super.key,
    required this.prefixController,
  });

  final TextEditingController prefixController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 2, color: Colors.redAccent),
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              const Text(
                "Prefix: ",
                style: TextStyle(fontSize: 18),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextField(
                    style: const TextStyle(fontSize: 18),
                    controller: prefixController,
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type hier een PREFIX voor je save-file',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
