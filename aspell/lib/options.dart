import 'package:aspell/classes/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String title = "ASpeLl";
const String picturePath = "assets/pictures/";

bool isDarkMode = false;
MaterialColor themeColor = Colors.amber;

// Save the value to shared preferences
Future<void> saveOptions() async
{
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool("isDarkMode", isDarkMode);
  prefs.setInt("themeColor", themeColorList.indexOf(themeColor));
} // end saveOptions

// Load the value from shared preferences
Future<void> loadOptions() async
{
  final prefs = await SharedPreferences.getInstance();
  isDarkMode = prefs.getBool("isDarkMode") == null ? false : prefs.getBool("isDarkMode")!;
  int curColor = prefs.getInt("themeColor") == null ? 0 : prefs.getInt("themeColor")!;
  themeColor = themeColorList[curColor];
} // end loadOptions

void loadDefaults()
{
  isDarkMode = false;
  themeColor = Colors.red;
} // end loadDefaults

Future<void> resetOptions() async
{
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
  loadDefaults();
} // end resetOptions