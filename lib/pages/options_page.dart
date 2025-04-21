// ignore_for_file: import_of_legacy_library_into_null_safe
// used to hopefully reload app?
import 'package:kittkatflutterlibrary/theming/src/theme.dart';
import 'package:universal_html/html.dart' as html;
import 'package:aspell/options.dart';
import 'package:flutter/material.dart';
// custom
import 'package:aspell/helpers_gui.dart';
import 'package:aspell/classes/widgets.dart';

class OptionsPage extends StatefulWidget {
  final String title;
  const OptionsPage({super.key, required this.title});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
} // end OptionsPage

class _OptionsPageState extends State<OptionsPage> {
  @override
  Widget build(BuildContext context) {
    var cycleColorBtn = ElevatedButton(
        onPressed: () {
          cycleColor();
          // appTheme.setColor(Colors.red);
          // Provider.of<ThemeModel>(context, listen: false).cycleColor();
          saveOptions();
        },
        child: const Text("Cycle Color"));
    var toggleModeBtn = ElevatedButton(
        onPressed: () {
          cycleMode();
          // appTheme.cycleThemeMode();
          // Provider.of<ThemeModel>(context, listen: false).toggleMode();
          saveOptions();
        },
        child: const Text("Toggle Mode"));
    var resetBtn = ElevatedButton(
        onPressed: () {
          resetOptions();
          // Provider.of<ThemeModel>(context, listen: false).toggleMode();
          saveOptions();
          // used with universal html import, refresh app hopefuly?
          html.window.location.reload();
        },
        child: const Text("Reset"));
    var titleText = Text(
      widget.title,
      textAlign: TextAlign.center,
      textScaleFactor: 2,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
    var row1 = Row(
      children: [
        Expanded(flex: 7, child: cycleColorBtn),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(flex: 7, child: toggleModeBtn)
      ],
    );
    var row2 = Row(
      children: [
        Expanded(flex: 7, child: resetBtn),
        const Expanded(flex: 1, child: SizedBox()),
        const Expanded(flex: 7, child: SizedBox())
      ],
    );
    var children = <Widget>[
      titleText,
      readFileWidget('assets/texts/options.md'),
      spacer,
      row1,
      spacer,
      row2,
      spacer,
      GoBackButton(context: context)
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PaddedScroll(
        context: context,
        children: children,
      ),
    );
  }
} // end _OptionsPageState
