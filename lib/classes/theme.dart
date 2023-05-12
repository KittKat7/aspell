// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// custom imports
import 'package:aspell/options.dart';

MaterialColor defColor = Colors.amber;
List<MaterialColor> themeColorList = 
 [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.purple, Colors.cyan];
Brightness mode = Brightness.light;


setColor(BuildContext context, MaterialColor color)
{
  Provider.of<ThemeModel>(context,listen: false).setColor(color);
} // end setColor

setMode(BuildContext context, Brightness mode)
{
  Provider.of<ThemeModel>(context,listen: false).setMode(mode);
} // end setColor

class ThemeModel with ChangeNotifier{

  ThemeData currentTheme = ThemeData(
    primarySwatch: themeColor,
    brightness: mode,
  );

  updateTheme()
  {
    mode = isDarkMode ? Brightness.dark : Brightness.light;
    currentTheme = ThemeData(
      primarySwatch: themeColor,
      brightness: mode,
    );
  } // end updateTheme

  ThemeData getThemeLight()
  {
    setMode(Brightness.light);
    return currentTheme;
  }

  ThemeData getThemeDark()
  {
    setMode(Brightness.dark);
    return currentTheme;
  }


  setMode(Brightness md)
  {
    mode = md;
    isDarkMode = mode == Brightness.dark;
    currentTheme = ThemeData(
      primarySwatch: themeColor,
      brightness: mode,
    );
    return notifyListeners();
  } // end setMode

  toggleMode() 
  {
    if (isDarkMode) {
      mode = Brightness.light;
      isDarkMode = false;
    } else {
      mode = Brightness.dark;
      isDarkMode = true;
    }
    currentTheme = ThemeData(
      primarySwatch: themeColor,
      brightness: mode,
    );
    return notifyListeners();
  } // end toggleMode

  setColor(MaterialColor clr)
  {
    themeColor = clr;
    currentTheme = ThemeData(
      primarySwatch: themeColor,
      brightness: mode,
    );
    return notifyListeners();
  } // end setColor

  setColorCyan()
  {
    themeColor = Colors.cyan;
    currentTheme = ThemeData(
      primarySwatch: themeColor,
      brightness: mode,
    );
    return notifyListeners();
  } // end setColor

  cycleColor()
  {
    if (!themeColorList.contains(themeColor)) {
      setColor(themeColorList[0]);
      int index = 0;
    } else {
      int index = themeColorList.indexOf(themeColor) + 1;
      setColor(themeColorList[index >= (themeColorList.length - 1) ? 0 : index]);
    }
  } // end cycleColor

  /*
  ThemeData theme = ThemeData(
    primarySwatch: defColor,
    brightness: Brightness.dark,
  );
  */
}