import 'package:flutter/material.dart';
import '../screens/about_screen.dart';
import '../screens/category_screen.dart';
import '../screens/home_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> menuTitles = [];
    menuTitles = ["Home", "Categories", "Export"];

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
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
        leading: getIcon(menuItem),
        title: Text(menuItem,
            style: theme.textTheme.headlineMedium!
                .copyWith(color: Colors.red.shade400)),
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

  Icon getIcon(String menuItem) {
    late IconData returnIcon;
    switch (menuItem) {
      case "Home":
        returnIcon = Icons.home;
        break;
      case "Categories":
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
      color: Colors.red.shade200,
      size: 28,
    );
  }

  Widget getScreen(String menuItem) {
    switch (menuItem) {
      case "Home":
        return const HomeScreen();
      case "Categories":
        return const CategoryScreen();
      case "Export":
        return const AboutScreen();
      default:
        return const HomeScreen();
    }
  }
}
