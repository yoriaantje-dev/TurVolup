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
        child: const Icon(Icons.add),
        onPressed: () async {
          helper.getFiles().then((List<File> files) {
            DateTime currentDate = DateTime.now();
            String fileName =
                "${prefixController.text}_${currentDate.day}_${currentDate.month}_${currentDate.year}";

            bool flag = false;
            for (File file in files) {
              if (basename(file.path) == fileName) {
                print("${basename(file.path)} is equal to $fileName");
                flag = true;
              }
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
                                files[index],
                                prefixController.text,
                              ),
                            ),
                          );
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
