import 'package:aspell/pages/learning_page.dart';
import 'package:flutter/material.dart';
import 'package:kittkatflutterlibrary/kittkatflutterlibrary.dart';

import '../classes/widgets.dart';
import 'options_page.dart';
import 'practice_page.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called,
    var appBar = AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      // also add secret cyan color
      title: styledTitle(),
    );

    Widget headerTxt = styledTitle(scale: 5);
    // Practice page button
    var practiceBtn = CustomButton(
      onPressed: () {
        Navigator.push(context, genRoute(const SpellPage()));
      },
      child: Text(getLang('btnStartPractice')),
    );
    // Learning page button
    var learnBtn = CustomButton(
      onPressed: () {
        Navigator.push(context, genRoute(const LearningPage()));
      },
      child: Text(getLang('btnStartLearning')),
    );
    // options page button
    var optionsBtn = CustomButton(
      onPressed: () {
        Navigator.push(context, genRoute(const OptionsPage()));
      },
      child: Text(getLang('btnSettings')),
    );
    // about page button
    var aboutBtn = CustomButton(
      onPressed: () {
        Navigator.push(context, genRoute(const AboutPage()));
      },
      child: Text(getLang('btnAbout')),
    );
    // display the buttons
    var column = verticalPaddingColumn(children: [
      Row(children: <Widget>[
        Expanded(flex: 5, child: practiceBtn),
      ]),
      Row(children: <Widget>[
        Expanded(flex: 5, child: learnBtn),
      ]),
      Row(children: <Widget>[
        Expanded(flex: 5, child: optionsBtn),
      ]),
      Row(children: <Widget>[
        Expanded(flex: 5, child: aboutBtn),
      ]),
    ]);

    // return the page display
    return Scaffold(
      appBar: appBar,
      body: PaddedScroll(context: context, children: <Widget>[
        verticalPaddingColumn(children: [
          headerTxt,
          column,
        ]),
      ]),
    );
  } // end build
} // end _HomePageState
