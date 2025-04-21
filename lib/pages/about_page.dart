import 'package:aspell/classes/widgets.dart';
import 'package:aspell/helpers_gui.dart';
import 'package:flutter/material.dart';
import 'package:kittkatflutterlibrary/kittkatflutterlibrary.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});
  @override
  State<AboutPage> createState() => _AboutPageState();
} // and AboutPage

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(getLang('titleApp')),
        ),
        body: PaddedScroll(
          context: context,
          children: children(context),
        ));
  }

  List<Widget> children(BuildContext context) {
    return <Widget>[
      Text(
        getLang('titleApp'),
        textAlign: TextAlign.center,
        textScaleFactor: 2,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      // main about
      Marked(getLang('txtAbout')),
      // spacer
      spacer,
      // back button
      GoBackButton(context: context),
    ];
  } // end build
} // end _AboutPageState
