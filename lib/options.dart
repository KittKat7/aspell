import 'package:flutter/material.dart';
import 'package:kittkatflutterlibrary/lang/kkfl_lang.dart';
import 'package:kittkatflutterlibrary/theming/src/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String picturePath = "assets/pictures/";

List<MaterialColor> _themeColorList = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.purple,
];

List<String> _themeColorNameList = [
  getLang('strRed'),
  getLang('strOrange'),
  getLang('strYellow'),
  getLang('strGreen'),
  getLang('strBlue'),
  getLang('strPurple'),
];

/// Optionsclass
/// A class that contains the options for the app
/// bool? isDarkMode
/// int themeColorIndex
/// int speed
/// int difficulty
///
class AppOptions {
  static const speedRange = (1, 7);
  static const difficultyRange = (3, 7);

  static const _defDarkMode = 0;
  static const _defThemeColorIndex = 0;
  static const _defSpeed = 1;
  static const _defDifficulty = 3;

  static SharedPreferences? _instance;

  static int _darkMode = _defDarkMode;
  static String get modeName {
    switch (_darkMode) {
      case 0:
        return getLang('strSystem');
      case 1:
        return getLang('strLight');
      case 2:
        return getLang('strDark');
      default:
        return getLang('strUnknown');
    }
  }

  static int _themeColorIndex = _defThemeColorIndex;
  static String get colorName => _themeColorNameList[_themeColorIndex];

  static int _speed = _defSpeed;
  static int get speed => _speed;
  static set speed(int speed) {
    _checkInit();
    speed < speedRange.$1 ? speedRange.$1 : speed;
    _speed = speed > speedRange.$2 ? speedRange.$2 : speed;
    _saveOptions();
  }

  static int _difficulty = _defDifficulty;
  static int get difficulty => _difficulty;
  static set difficulty(int difficulty) {
    _checkInit();
    difficulty < difficultyRange.$1 ? difficultyRange.$1 : difficulty;
    _difficulty =
        difficulty > difficultyRange.$2 ? difficultyRange.$2 : difficulty;
    _saveOptions();
  }

  static Future<bool> initialize({
    int darkMode = _defDarkMode,
    int themeColor = _defThemeColorIndex,
    int speed = _defSpeed,
    int difficulty = _defDifficulty,
  }) async {
    // If the instance is null
    if (_instance == null) {
      try {
        _instance = await SharedPreferences.getInstance();
      } catch (e) {
        return false;
      }
    }

    // Load values or use default values
    SharedPreferences prefs = _instance!;
    _darkMode = prefs.getInt('darkMode') ?? _defDarkMode;
    _themeColorIndex = prefs.getInt('colorIndex') ?? _defThemeColorIndex;
    _speed = prefs.getInt('speed') ?? _defSpeed;
    _difficulty = prefs.getInt('difficulty') ?? _defDifficulty;

    return true;
  }

  static void _checkInit() {
    if (_instance == null) {
      throw Exception('AppOptions not initiated!!!');
    }
  }

  static void _saveOptions() {
    _checkInit();
    _instance!.setInt('darkMode', _darkMode);
    _instance!.setInt('colorIndex', _themeColorIndex);
    _instance!.setInt('speed', _speed);
    _instance!.setInt('difficulty', _difficulty);
  }

  static void applyTheme() {
    _checkInit();
    switch (_darkMode) {
      case 0:
        appTheme.setSystemMode();
        break;
      case 1:
        appTheme.setLightMode();
        break;
      case 2:
        appTheme.setDarkMode();
        break;
    }
    appTheme.setColor(_themeColorList[_themeColorIndex]);
  }

  /// Cycle the brightness mode
  /// System -> Light
  /// Light -> Dark
  /// Dark -> System
  static void cycleMode() {
    _checkInit();
    switch (_darkMode) {
      case 0:
        _darkMode = 1;
        appTheme.setLightMode();
        break;
      case 1:
        _darkMode = 2;
        appTheme.setDarkMode();
        break;
      case 2:
        _darkMode = 0;
        appTheme.setSystemMode();
        break;
    }
    _saveOptions();
  }

  static void cycleColor() {
    _checkInit();
    _themeColorIndex = (++_themeColorIndex) % _themeColorList.length;
    appTheme.setColor(_themeColorList[_themeColorIndex]);
    _saveOptions();
  }

  static void loadDefaults() {
    _checkInit();
    initialize();
  }

  static void resetOptions() {
    _checkInit();
    _instance!.clear();
  }
}
