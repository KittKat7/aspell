import 'package:flutter/material.dart';
import 'package:kittkatflutterlibrary/kittkatflutterlibrary.dart';

import '../classes/widgets.dart';
import 'options_page.dart';
import 'spelling_page.dart';
import '../helpers_gui.dart';
import '../options.dart';
import 'about_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
} // end HomePage

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadWords();
    loadLetters();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called,
    var appBar = AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        // also add secret cyan color
        title: GestureDetector(
            onTap: () {
              // Provider.of<ThemeModel>(context, listen: false).setColorCyan();
              setColorCyan();
              saveOptions();
            },
            child: Text(getLang('titleApp'))));
    // header text
    Text headerTxt = Text(
      getLang('titleApp'),
      textScaleFactor: 5,
    );
    // spelling page button
    var spellBtn = ElevatedButton(
      onPressed: () {
        Navigator.push(context, genRoute(const SpellPage()));
        // Navigator.pushNamed(context, '/spell');
      },
      child: Text(getLang('btnStart')),
    );
    // options page button
    var optionsBtn = ElevatedButton(
      onPressed: () {
        Navigator.push(context, genRoute(const OptionsPage()));
        // Navigator.pushNamed(context, '/options');
      },
      child: Text(getLang('btnSettings')),
    );
    // about page button
    var aboutBtn = ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          genRoute(const AboutPage()),
        );
        // Navigator.pushNamed(context, '/about');
      },
      child: Text(getLang('btnAbout')),
    );
    // spacer object
    var sideSpacer = const Expanded(flex: 0, child: SizedBox());
    // display the buttons
    var column = Column(children: <Widget>[
      Row(children: <Widget>[
        sideSpacer,
        Expanded(flex: 5, child: spellBtn),
        sideSpacer,
      ]),
      spacer,
      Row(children: <Widget>[
        sideSpacer,
        Expanded(flex: 5, child: optionsBtn),
        sideSpacer,
      ]),
      spacer,
      Row(children: <Widget>[
        sideSpacer,
        Expanded(flex: 5, child: aboutBtn),
        sideSpacer,
      ])
    ]);

    // return the page display
    return Scaffold(
      appBar: appBar,
      body: PaddedScroll(context: context, children: <Widget>[
        headerTxt,
        spacer,
        const Text(""), // sub heading text
        spacer,
        column,
      ]),
    );
  } // end build
} // end _HomePageState
