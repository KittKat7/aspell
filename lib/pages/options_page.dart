// ignore_for_file: import_of_legacy_library_into_null_safe
// used to hopefully reload app?
import 'package:kittkatflutterlibrary/kittkatflutterlibrary.dart';
import 'package:universal_html/html.dart' as html;
import 'package:aspell/options.dart';
import 'package:flutter/material.dart';
// custom
import '../classes/widgets.dart';

class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
} // end OptionsPage

class _OptionsPageState extends State<OptionsPage> {
  @override
  Widget build(BuildContext context) {
    var cycleColorBtn = CustomButton(
      onPressed: () {
        cycleColor();
        // appTheme.setColor(Colors.red);
        // Provider.of<ThemeModel>(context, listen: false).cycleColor();
        saveOptions();
      },
      child: Text(getLang('btnCycleColor')),
    );

    var toggleModeBtn = CustomButton(
      onPressed: () {
        cycleMode();
        // appTheme.cycleThemeMode();
        // Provider.of<ThemeModel>(context, listen: false).toggleMode();
        saveOptions();
      },
      child: Text(getLang('btnToggleColor')),
    );

    var resetBtn = CustomButton(
      onPressed: () {
        resetOptions();
        // Provider.of<ThemeModel>(context, listen: false).toggleMode();
        saveOptions();
        // used with universal html import, refresh app hopefuly?
        html.window.location.reload();
      },
      child: Text(getLang('btnResetSettings')),
    );

    var titleText = Text(
      getLang('titleApp'),
      textAlign: TextAlign.center,
      textScaler: TextScaler.linear(2),
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
      verticalPaddingColumn(children: [
        titleText,
        Marked(getLang('txtOptions')),
        // readFileWidget('assets/texts/options.md'),
        row1,
        row2,
        GoBackButton(context: context)
      ])
    ];

    return Scaffold(
      appBar: AppBar(
        title: styledTitle(),
      ),
      body: PaddedScroll(
        context: context,
        children: children,
      ),
    );
  }
} // end _OptionsPageState
