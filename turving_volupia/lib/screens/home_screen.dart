// ignore_for_file: avoid_print
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:turving_volupia/screens/widgets/file_prefix_bar.dart';

// Disabled for Release v0.0.1
// ignore: unused_import
import '../data/file_helper.dart';
import '../shared/menu_drawer.dart';
import 'turf_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController prefixController = TextEditingController();
  FileHelper helper = FileHelper();

  @override
  Widget build(BuildContext context) {
    if (prefixController.text == "") {
      prefixController.text = "BAR";
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      drawer: const MenuDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          //TODO: Navigate to a new turf screen with the date and prefix filename
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TurfScreen(null, prefixController.text)));
        },
      ),
      body: Column(
        children: [
          FilePrefixBar(prefixController: prefixController),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text("Selecteer een bestand om in te werken: ", style: TextStyle(fontSize: 19),),
          ),
          Expanded(
            child: FutureBuilder(
              future: helper.getFiles(),
              builder: (context, snapshot) {
                List<File> files = snapshot.data ?? [];
                return ListView.builder(
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(files[index].toString()),
                      onDismissed: (direction) {
                        helper.deleteFile(files[index]);
                      },
                      child: ListTile(
                        title: Text(basename(files[index].path)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TurfScreen(
                                      files[index], prefixController.text)));
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
