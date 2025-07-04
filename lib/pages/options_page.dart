// ignore_for_file: import_of_legacy_library_into_null_safe
// used to hopefully reload app?
import 'package:aspell/classes/letter_signs.dart';
import 'package:kittkatflutterlibrary/kittkatflutterlibrary.dart';
import 'package:universal_html/html.dart' as html;
import 'package:aspell/classes/options.dart';
import 'package:flutter/material.dart';
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
        setState(() => AppOptions.cycleColor());
      },
      child: Text(getLang('btnCycleColor', [AppOptions.colorName])),
    );

    var toggleModeBtn = CustomButton(
      onPressed: () {
        setState(() => AppOptions.cycleMode());
      },
      child: Text(getLang('btnToggleColor', [AppOptions.modeName])),
    );

    var chooseLetterSetBtn = CustomButton(
      onPressed: () {
        // make a list of buttons
        List<Widget> buttons = [];
        for (String letterSet in Letters.letterSets) {
          Widget btn = CustomButton(
            onPressed: () {
              setState(() => AppOptions.letterSet = letterSet);
              Letters.currentLetters!.cacheImages(context);
              Navigator.pop(context);
            },
            child: Text(letterSet),
          );
          buttons.add(Row(children: [
            Expanded(flex: 1, child: verticalPadding(child: btn))
          ]));
        }

        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Marked(getLang('hdrChooseSignSet')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: buttons,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(getLang('btnCancel')),
              )
            ],
          ),
        );
      },
      child: Text(
          getLang('btnChooseLetterSet', [Letters.currentLetters!.letterSet])),
    );

    var resetBtn = CustomButton(
      onPressed: () {
        setState(() {
          AppOptions.resetOptions();
          AppOptions.loadDefaults();
        });
        if (platformIsWeb) {
          html.window.location.reload();
        }
      },
      child: Text(getLang('btnResetSettings')),
    );

    var row1 = Row(
      children: [
        Expanded(flex: 7, child: cycleColorBtn),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(flex: 7, child: toggleModeBtn),
      ],
    );

    var row2 = Row(
      children: [
        Expanded(flex: 7, child: chooseLetterSetBtn),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(flex: 7, child: resetBtn),
      ],
    );

    var children = <Widget>[
      verticalPaddingColumn(children: [
        styledTitle(scale: 3),
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
