import 'package:aspell/classes/letter_signs.dart';
import 'package:aspell/classes/widgets.dart';
import 'package:flutter/material.dart';
import 'package:kittkatflutterlibrary/kittkatflutterlibrary.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({super.key});
  @override
  State<LearningPage> createState() => _LearningPageState();
} // and AboutPage

class _LearningPageState extends State<LearningPage> {
  @override
  Widget build(BuildContext context) {
    Widget grid = GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        for (String char in Letters.currentLetters!.letters.keys)
          LetterSignCard(
              image: Letters.currentLetters!.letters[char]!, title: char),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: styledTitle(),
      ),
      body: PaddedScroll(
        context: context,
        children: [
          verticalPaddingColumn(children: [
            styledTitle(scale: 3),
            // main about
            Marked(getLang('txtLearningPage')),
            grid,
            // back button
            GoBackButton(context: context),
          ])
        ],
      ),
    );
  }
} // end _AboutPageState

class LetterSignCard extends StatelessWidget {
  final Widget image; // The cat image widget
  final String title; // Text under the image

  const LetterSignCard({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            image,
            Text(title, textScaler: TextScaler.linear(3)),
          ],
        ),
      ),
    );
  }
}
