import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  final Function(String) functionAddItem;
  final Function functionSave;
  final Function functionDelete;

  const MenuDrawer({super.key, 
    required this.functionAddItem,
    required this.functionSave,
    required this.functionDelete,
  });
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Burger Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              // Handle Home selection
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Menu Item 1'),
            onTap: () {
              // Handle Menu Item 1 selection
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Menu Item 2'),
            onTap: () {
              // Handle Menu Item 2 selection
              Navigator.pop(context);
            },
          ),
          // Add more ListTile widgets for additional menu items
        ],
      ),
    );
  }
}