import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:turving_volupia/main.dart';

import '../data/file_helper.dart';
import '../data/models/turv_model.dart';
import '../shared/menu_drawer.dart';
import '../shared/popup_dialog.dart';

import 'widgets/flow_menu.dart';
import 'widgets/turf_item.dart';

class TurfScreen extends StatefulWidget {
  const TurfScreen(this.file, this.prefix, {super.key});
  final File? file;
  final String prefix;

  @override
  State<TurfScreen> createState() => _TurfScreenState();
}

class _TurfScreenState extends State<TurfScreen> with WidgetsBindingObserver {
  TurvCollection? collection;
  bool loadedFromFile = false;
  FileHelper helper = FileHelper();

  Color snackbarTextColor() => context.isDarkMode ? Colors.black : Colors.white;
  Color snackbarBackgroundColor() => context.isDarkMode ? Colors.white : Colors.grey;

  Future<bool> _loadFromFile() async {
    if (widget.file != null) {
      String jsonString = await helper.readFromFile(widget.file!);
      Map<String, dynamic> mappedJson = jsonDecode(jsonString);
      TurvCollection returnThis = TurvCollection.fromJSON(mappedJson);
      setState(() {
        collection = returnThis;
      });
      return true;
    }
    setState(() {
      //TODO: Get rid of the exampleCollection (Needs to be configured/ generated!)
      collection = TurvCollection.exampleCollection(widget.prefix);
    });
    return false;
  }

  void _addTurvableItem() async {
    final item = await showDialog<TurvableItem>(
      context: context,
      builder: (context) => const AddTurvableItemDialog(),
    );
    if (item != null) {
      setState(() {
        collection!.items.add(item);
      });
    }
  }

  void _saveTurfCollection({bool silent = false}) async {
    List<TurvableItem> saveList = [];
    for (TurvableItem item in collection!.items) {
      saveList.add(item);
    }
    collection!.items = saveList;
    helper.saveCollection(collection!);
    if (!silent) {
      _savedMessage();
    }
  }

  void _showLoadingStatus(bool status) {
    if (status) {
      SnackBar snackBar = SnackBar(
        content: Text(
          "Loaded from file.",
          style: TextStyle(
              color: snackbarTextColor()),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: snackbarBackgroundColor(),
      );
      _showSnackBar(snackBar);
    } else {
      SnackBar snackBar = SnackBar(
        content: Text(
          "Defaults loaded.",
          style: TextStyle(
              color: snackbarTextColor()),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: snackbarBackgroundColor(),
      );
      _showSnackBar(snackBar);
    }
  }

  void _showSnackBar(SnackBar snackBar) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _savedMessage() {
    try {
      SnackBar snackBar = SnackBar(
        content: Text("Saved succesfully.",
        style:
            TextStyle(color: snackbarTextColor()),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: snackbarBackgroundColor(),
        );
      _showSnackBar(snackBar);
    } catch (e) {
      if (kDebugMode) {
        print("Error when showing save message: $e");
      }
    }
  }

  void addOne(int index) {
    setState(() {
      collection!.items[index].add(1);
    });
  }

  void removeOne(int index) {
    setState(() {
      collection!.items[index].remove(1);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFromFile().then((bool value) {
      setState(() {
        loadedFromFile = value;
      });
      Future.delayed(Duration.zero, () {
        _showLoadingStatus(value);
      });
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        _saveTurfCollection(silent: true);
        break;
      case AppLifecycleState.resumed:
        _saveTurfCollection(silent: true);
        break;
      case AppLifecycleState.paused:
        _saveTurfCollection(silent: true);
        break;
      case AppLifecycleState.detached:
        _saveTurfCollection(silent: true);
        break;
      default:
        _saveTurfCollection(silent: true);
        break;
    }
  }

  @override
  void dispose() {
    _saveTurfCollection(silent: true);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void deactivate() {
    _saveTurfCollection(silent: true);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Get rid of the exampleCollection (Needs to be configured/ generated!)
    collection ??= TurvCollection.exampleCollection(widget.prefix);

    return Scaffold(
      appBar: AppBar(title: const Text("Turf")),
      drawer: const MenuDrawer(),
      floatingActionButton: floatingActionMenu(
          context.isDarkMode, _addTurvableItem, _saveTurfCollection),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: collection!.items.length,
          itemBuilder: (BuildContext context, int index) {
            return TurfItemCard(
              item: collection!.items[index],
              addOne: () {
                addOne(index);
              },
              removeOne: () {
                removeOne(index);
              },
            );
          },
        ),
      ),
    );
  }
}
