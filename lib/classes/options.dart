import 'package:aspell/classes/letter_signs.dart';
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

/// AppOptions
/// Controls options used in the app. Options include [themeMode]: whether to use light, dark, or
/// system mode. [themeColorIndex] the index of the color theme, changing this changes the color
/// theme. [speed] the number of signs per second to show for fingerspelling, range 1 to 7.
/// [difficulty] the number of letters to use for choosing words, range 3 to 7+. [letterSet] the
/// set of letter signs to use for fingerspelling.
class AppOptions {
  static const _speedRange = (1, 7);
  static const _difficultyRange = (3, 7);

  static const _defThemeMode = 0;
  static const _defThemeColorIndex = 0;
  static const _defSpeed = 1;
  static const _defDifficulty = 3;
  static const _defLetterSet = 'avery';

  static SharedPreferences? _instance;

  /// Whether the app is in dark mode. 0 -> system, 1 -> light, 2 -> dark
  static int _themeMode = _defThemeMode;

  /// Get for the name of the theme mode
  static String get modeName {
    switch (_themeMode) {
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

  /// Set the theme mode, 0 -> System, 1 -> Light, 2 -> Dark
  static set themeMode(int themeMode) {
    _checkInit();
    _themeMode = themeMode % 3;
    switch (_themeMode) {
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
    _instance!.setInt('themeMode', _themeMode);
  }

  /// The index from the list of colors for the color setting
  static int _themeColorIndex = _defThemeColorIndex;

  /// Get the name of the color related to the [_themeColorIndex]
  static String get colorName => _themeColorNameList[_themeColorIndex];

  /// Set the theme color through index of [_themeColorIndex]
  static set themeColorIndex(int index) {
    _checkInit();
    _themeColorIndex = (index) % _themeColorList.length;
    appTheme.setColor(_themeColorList[_themeColorIndex]);
    _instance!.setInt('colorIndex', _themeColorIndex);
  }

  /// The speed of signing
  static int _speed = _defSpeed;

  /// Get the speed
  static int get speed => _speed;

  /// Set the speed
  static set speed(int speed) {
    _checkInit();
    speed < _speedRange.$1 ? _speedRange.$1 : speed;
    _speed = speed > _speedRange.$2 ? _speedRange.$2 : speed;
    _instance!.setInt('speed', _speed);
  }

  /// The difficulty
  static int _difficulty = _defDifficulty;

  /// Get the difficulty
  static int get difficulty => _difficulty;

  /// Set the difficulty
  static set difficulty(int difficulty) {
    _checkInit();
    difficulty < _difficultyRange.$1 ? _difficultyRange.$1 : difficulty;
    _difficulty =
        difficulty > _difficultyRange.$2 ? _difficultyRange.$2 : difficulty;
    _instance!.setInt('difficulty', _difficulty);
  }

  /// The letterSet to use
  static String _letterSet = _defLetterSet;

  /// Get the letterSet
  static String get letterSet => _letterSet;

  /// Set the letterSet
  static set letterSet(String letterSet) {
    _checkInit();
    if (!Letters.letterSets.contains(letterSet)) {
      letterSet = _defLetterSet;
    }
    _letterSet = letterSet;
    Letters.currentLetters = Letters(letterSet: _letterSet);
    _instance!.setString('letterSet', _letterSet);
  }

  /// initialize
  /// initialized the AppOptions instance and the SharedPreferences instance. If SharedPreferences
  /// is not initialized, try and initialize it. Returns false if SharedPreferences cannot be
  /// initialized. Otherwise continue to load the AppOption fields from SharedPreferences and
  /// return true.
  static Future<bool> initialize() async {
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
    themeMode = prefs.getInt('themeMode') ?? _defThemeMode;
    themeColorIndex = prefs.getInt('colorIndex') ?? _defThemeColorIndex;
    speed = prefs.getInt('speed') ?? _defSpeed;
    difficulty = prefs.getInt('difficulty') ?? _defDifficulty;
    letterSet = prefs.getString('letterSet') ?? _defLetterSet;

    return true;
  }

  /// _checkInit
  /// checks if the shared_preferences instance has been initialized. Throw an [Exception] if
  /// shared_preferences has not been initialized.
  static void _checkInit() {
    if (_instance == null) {
      throw Exception('AppOptions not initiated!!!');
    }
  }

  /// _saveAllOptions
  /// sets all options to their current state which triggers a save for each item.
  static void _saveAllOptions() {
    _checkInit();
    themeMode = _themeMode;
    themeColorIndex = _themeColorIndex;
    speed = _speed;
    difficulty = _difficulty;
    letterSet = _letterSet;
  }

  /// cycleMode
  /// cycles the theme mode. System -> Light -> Dark ->
  static void cycleMode() {
    themeMode = _themeMode + 1;
  }

  /// cycleColor
  /// cycles the theme color. Red -> Orange -> Yellow -> Green -> Blue -> Purple ->
  static void cycleColor() {
    themeColorIndex = _themeColorIndex + 1;
  }

  /// loadDefaults
  /// loads the default values for all settings which also triggers saves for all settings.
  static void loadDefaults() {
    _checkInit();
    themeMode = _defThemeMode;
    themeColorIndex = _defThemeColorIndex;
    speed = _defSpeed;
    difficulty = _defDifficulty;
    letterSet = _defLetterSet;
  }

  /// resetOptions
  /// clears the shared_preferences instance.
  static void resetOptions() {
    _checkInit();
    _instance!.clear();
  }
}
