import 'package:flutter/material.dart';
import 'package:rotten/common/tab_navigator.dart';
import 'package:rotten/common/theme_mode_provider.dart';
import 'package:rotten/modules/calander/calander_home_page.dart';
import 'package:rotten/modules/finance/finance_home_page.dart';
import 'package:rotten/modules/fitness/fitness_home_page.dart';
import 'package:rotten/modules/food/food_home_page.dart';
import 'package:rotten/modules/habits/habits_home_page.dart';
import 'package:rotten/modules/hobbies/hobbies_home_page.dart';
import 'package:rotten/samples/pages/favorites_page.dart';
import 'package:rotten/samples/pages/generator_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  ThemeModeProvider currentTheme = ThemeModeProvider();

  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {
        // print("work");
        // print(currentTheme.getPreferences());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

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
                  leading: IconButton(
                      icon: currentTheme.isDark
                          ? Icon(Icons.nightlight_round)
                          : Icon(Icons.sunny),
                      onPressed: (() {
                        currentTheme.isDark = !currentTheme.isDark;
                      })),
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

final List<TabNavigator> navigation = [
  TabNavigator(Icon(Icons.home), 'Home', GeneratorPage()),
  TabNavigator(Icon(Icons.calendar_view_month), 'Calander', CalanderHomePage()),
  TabNavigator(Icon(Icons.money), 'Finance', FinanceHomePage()),
  TabNavigator(Icon(Icons.fitness_center), 'Fitness', FitnessHomePage()),
  TabNavigator(Icon(Icons.food_bank), 'Food', FoodHomePage()),
  TabNavigator(Icon(Icons.pattern), 'Habits', HabitsHomePage()),
  TabNavigator(Icon(Icons.piano), 'Hobbies', HobbiesHomePage()),
  TabNavigator(Icon(Icons.favorite), 'Favorites', FavoritesPage()),
];
