import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:turving_volupia/main.dart';
import 'package:turving_volupia/screens/widgets/file_prefix_bar.dart';
import '../data/file_helper.dart';
import '../shared/menu_drawer.dart';
import '../shared/popup_dialog.dart';
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
        backgroundColor: context.isDarkMode ? Colors.red.shade800 : Colors.red,
        onPressed: () async {
          helper.getFiles().then((List<File> files) {
            DateTime currentDate = DateTime.now();
            String fileName =
                "${prefixController.text}_${currentDate.day}_${currentDate.month}_${currentDate.year}";

            bool flag = false;
            for (File file in files) {
              if (basename(file.path) == fileName) flag = true;
            }
            if (flag) {
              confirmOverwriteFile(context, prefixController.text);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TurfScreen(
                    null,
                    prefixController.text,
                  ),
                ),
              );
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          FilePrefixBar(prefixController: prefixController),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Selecteer een bestand om in te werken: ",
              style: TextStyle(fontSize: 19),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: helper.getFiles(),
              builder: (context, snapshot) {
                List<File> files = snapshot.data ?? [];
                return ListView.builder(
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.redAccent,
                        child: ListTile(
                          title: Text(
                            basename(files[index].path),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          trailing: IconButton(
                            color: Colors.white,
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _deleteItem(context, files, index);
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TurfScreen(
                                  files[index],
                                  prefixController.text,
                                ),
                              ),
                            );
                          },
                        ),
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

  void _deleteItem(BuildContext context, List<File> files, int index) {
    final SnackBar deleteSnackBar = SnackBar(
      content: Text(
        '${basename(files[index].path)} verwijderd.',
        style:
            TextStyle(color: context.isDarkMode ? Colors.black : Colors.white),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: context.isDarkMode ? Colors.white : Colors.grey,
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(deleteSnackBar);

    helper.deleteFile(files[index]);
    setState(() {
      files.removeAt(index);
    });
  }
}
