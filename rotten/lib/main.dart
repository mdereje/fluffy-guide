// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:provider/provider.dart';
import 'package:rotten/common/theme_mode_provider.dart';
import 'package:rotten/home_page.dart';

import 'themes/dark_mode_orange.dart';
import 'themes/pink_blue.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeModeProvider currentTheme = ThemeModeProvider();

  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {
        print("work");
        // print(currentTheme.getPreferences());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rotten',
        theme: ThemeDecoder.decodeThemeData(bluePinkTheme),
        darkTheme: ThemeDecoder.decodeThemeData(darkModeOrange),
        themeMode: currentTheme.isDark ? ThemeMode.dark : ThemeMode.light,
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var history = <WordPair>[];

  GlobalKey? historyListKey;

  void getNext() {
    history.insert(0, current);
    var animatedList = historyListKey?.currentState as AnimatedListState?;
    animatedList?.insertItem(0);
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite([WordPair? pair]) {
    pair = pair ?? current;
    if (favorites.contains(pair)) {
      favorites.remove(pair);
    } else {
      favorites.add(pair);
    }
    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    notifyListeners();
  }
}
