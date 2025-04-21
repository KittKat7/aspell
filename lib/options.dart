import 'package:flutter/material.dart';
import 'package:kittkatflutterlibrary/theming/src/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String title = "ASpeLl";
const String picturePath = "assets/pictures/";

bool isDarkMode = false;
MaterialColor themeColor = Colors.amber;

MaterialColor defColor = Colors.amber;
List<MaterialColor> themeColorList = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.purple,
  Colors.cyan
];
Brightness mode = Brightness.light;

void cycleMode() {
  isDarkMode = !isDarkMode;
  if (isDarkMode) {
    appTheme.setDarkMode();
  } else {
    appTheme.setLightMode();
  }
}

void cycleColor() {
  if (!themeColorList.contains(themeColor)) {
    themeColor = themeColorList[0];
    appTheme.setColor(themeColor);
  } else {
    int index = themeColorList.indexOf(themeColor) + 1;
    themeColor =
        themeColorList[index >= (themeColorList.length - 1) ? 0 : index];
    appTheme.setColor(themeColor);
  }
  // int index = themeColorList.indexOf(themeColor) + 1;
  // themeColor = themeColorList[index >= themeColorList.length ? 0 : index];
  // appTheme.setColor(themeColor);
} // end cycleColor

void setColorCyan() {
  themeColor = Colors.cyan;
  appTheme.setColor(themeColor);
} // end setColor

// Save the value to shared preferences
Future<void> saveOptions() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool("isDarkMode", isDarkMode);
  prefs.setInt("themeColor", themeColorList.indexOf(themeColor));
} // end saveOptions

// Load the value from shared preferences
Future<void> loadOptions() async {
  final prefs = await SharedPreferences.getInstance();
  isDarkMode = prefs.getBool("isDarkMode") == null
      ? false
      : prefs.getBool("isDarkMode")!;
  int curColor =
      prefs.getInt("themeColor") == null ? 0 : prefs.getInt("themeColor")!;
  themeColor = themeColorList[curColor];
} // end loadOptions

void loadDefaults() {
  isDarkMode = false;
  themeColor = Colors.red;
} // end loadDefaults

Future<void> resetOptions() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
  loadDefaults();
} // end resetOptions

void setAppThemeData() {
  appTheme.setColor(themeColor);

  if (isDarkMode) {
    appTheme.setDarkMode();
  } else {
    appTheme.setLightMode();
  }
}
