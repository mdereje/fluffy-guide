import 'package:flutter/material.dart';
import 'package:rotten/samples/pages/favorites_page.dart';
import 'package:rotten/samples/pages/generator_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    // The container for the current page, with its background color
    // and subtle switching animation.
    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: navigation.elementAt(selectedIndex).page,
      ),
    );

    return Scaffold(
      body: navigationLayout(mainArea),
    );
  }

  LayoutBuilder navigationLayout(ColoredBox mainArea) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 450) {
          // Use a more mobile-friendly layout with BottomNavigationBar
          // on narrow screens.
          return Column(
            children: [
              Expanded(child: mainArea),
              SafeArea(
                child: BottomNavigationBar(
                  items: List.generate(
                      navigation.length,
                      (index) => BottomNavigationBarItem(
                            icon: navigation.elementAt(index).icon,
                            label: navigation.elementAt(index).label,
                          )),
                  currentIndex: selectedIndex,
                  onTap: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              )
            ],
          );
        } else {
          return Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: List.generate(
                      navigation.length,
                      (index) => NavigationRailDestination(
                            icon: navigation.elementAt(index).icon,
                            label: Text(navigation.elementAt(index).label),
                          )),
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(child: mainArea),
            ],
          );
        }
      },
    );
  }
}

final List<Navigator> navigation = [
  Navigator(Icon(Icons.home), 'Home', GeneratorPage()),
  Navigator(Icon(Icons.favorite), 'Favorites', FavoritesPage()),
];

class Navigator {
  Icon icon;
  String label;
  Widget page;

  Navigator(this.icon, this.label, this.page);
}
