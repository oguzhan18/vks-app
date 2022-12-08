import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum MainPageState { wallets, history, combined }

class ThemeService extends ChangeNotifier {
  late ThemeMode curThemeMode;
  late MainPageState mainPageState;

  Future<void> load() async {
    var prefs = await SharedPreferences.getInstance();
    String mode = prefs.getString('theme-mode') ?? 'system';
    curThemeMode = ThemeMode.values.firstWhere((m) => m.name == mode);
    String sMps = prefs.getString('main-page-state') ?? 'combined';
    mainPageState = MainPageState.values.firstWhere((mps) => mps.name == sMps);
  }

  setMainPageState(MainPageState mps) async {
    mainPageState = mps;
    notifyListeners();
  }

  Future<void> setCurThemeMode(ThemeMode newThemeMode) async {
    curThemeMode = newThemeMode;
    notifyListeners();
    await (await SharedPreferences.getInstance())
        .setString('theme-mode', newThemeMode.name);
  }

  late ThemeData lightTheme;
  late ThemeData darkTheme;

  static const double defaultPadding = 8;
  static const Color darkBackground = Color(0xFF121212);
  static const Color secondary = Color(0xffb5a33f);
  static const Color primary = Colors.indigo;

  ThemeService() {
    var defaultShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultPadding));
    var elevatedButtonThemeData = ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      minimumSize: const Size(70, 40),
      shape: defaultShape,
    ));
    var textButtonThemeData = TextButtonThemeData(
        style: TextButton.styleFrom(
      // tapTargetSiz
      minimumSize: const Size(70, 40),
      shape: defaultShape,
    ));
    var cardThemeData = CardTheme(
      shape: defaultShape,
    );
    var inputThemeData = InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultPadding)));
    var appBarTheme = const AppBarTheme();
    var font = 'myExo2';
    lightTheme = ThemeData(
        fontFamily: font,
        elevatedButtonTheme: elevatedButtonThemeData,
        textButtonTheme: textButtonThemeData,
        cardTheme: cardThemeData,
        inputDecorationTheme: inputThemeData,
        appBarTheme: appBarTheme,
        colorScheme: const ColorScheme.light(
            primary: Colors.indigo,
            onPrimary: Colors.white,
            secondary: secondary,
            onSecondary: Colors.black));
    darkTheme = ThemeData(
      fontFamily: font,
      elevatedButtonTheme: elevatedButtonThemeData,
      textButtonTheme: textButtonThemeData,
      cardTheme: cardThemeData,
      inputDecorationTheme: inputThemeData,
      appBarTheme: appBarTheme,
      colorScheme: ColorScheme.dark(
        brightness: Brightness.dark,
        primary: Colors.indigo.shade200,
        onPrimary: Colors.black,
        secondary: secondary,
        onSecondary: Colors.black,
      ),
    );
    // loadThemeMode().then((newThemeMode) => setCurThemeMode(newThemeMode));
  }
}
