import 'package:aspell/classes/widgets.dart';
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
        title: styledTitle(),
      ),
      body: PaddedScroll(
        context: context,
        children: [
          verticalPaddingColumn(children: [
            Text(
              getLang('titleApp'),
              textAlign: TextAlign.center,
              textScaler: TextScaler.linear(2),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            // main about
            Marked(
              getLang('txtAbout'),
              selectable: true,
            ),
            // back button
            GoBackButton(context: context),
          ])
        ],
      ),
    );
  }
} // end _AboutPageState
