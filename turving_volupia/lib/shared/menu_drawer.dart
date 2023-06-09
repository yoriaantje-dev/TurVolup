import 'package:flutter/material.dart';
import 'package:turving_volupia/main.dart';
import '../screens/about_screen.dart';
import '../screens/default_item_screen.dart';
import '../screens/home_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> menuTitles = [];
    menuTitles = ["Home", "Standaard Items", "Export"];

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.isDarkMode ? Colors.red[700] : Colors.red[200],
            ),
            child: Center(
              child: Image.asset(
                "assets/VolupiaLogo_WIT.png",
                fit: BoxFit.fitHeight,
                ),
            ),
          ),
          Expanded(
            child: ListView(
              children: makeDrawerContent(context, menuTitles),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> makeDrawerContent(
      BuildContext context, List<String> menuTitles) {
    final ThemeData theme = Theme.of(context);
    List<Widget> menuItems = [];

    for (String menuItem in menuTitles) {
      Widget screen = Container();
      menuItems.add(ListTile(
        leading: getIcon(menuItem, context.isDarkMode),
        title: Text(menuItem,
            style: theme.textTheme.headlineMedium!
                .copyWith(color: Colors.red.shade400,fontSize: 26)),
        onTap: () {
          screen = getScreen(menuItem);
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => screen),
          );
        },
      ));
    }
    return menuItems;
  }

  Icon getIcon(String menuItem, bool isDarkMode) {
    late IconData returnIcon;
    switch (menuItem) {
      case "Home":
        returnIcon = Icons.home;
        break;
      case "Standaard Items":
        returnIcon = Icons.list_rounded;
        break;
      case "Export":
        returnIcon = Icons.send_to_mobile;
        break;
      default:
        returnIcon = Icons.question_mark;
        break;
    }
    return Icon(
      returnIcon,
      color: isDarkMode ? Colors.red[700] : Colors.redAccent,
      size: 35,
    );
  }

  Widget getScreen(String menuItem) {
    switch (menuItem) {
      case "Home":
        return const HomeScreen();
      case "Standaard Items":
        return const DefaultItemScreen();
      case "Export":
        return const AboutScreen();
      default:
        return const HomeScreen();
    }
  }
}
