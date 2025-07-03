import 'dart:async';
import 'package:aspell/classes/letter_signs.dart';
import 'package:aspell/classes/wordlist.dart';
import 'package:flutter/material.dart';
// custom
import 'package:aspell/helpers_gui.dart';
import 'package:aspell/classes/widgets.dart';
import 'package:kittkatflutterlibrary/kittkatflutterlibrary.dart';

int counter = 0;
double signSpeed = 1;
int wordLength = 5;
int score = 0;
String wordLast = "";
String _lastLetter = "";
bool lastOffset = false;
String correct = "";

/* ========== SPELLING ========== */
/* SPELL */
class SpellPage extends StatefulWidget {
  const SpellPage({super.key});
  @override
  State<SpellPage> createState() => _SpellPageState();
} // end SpellPage

class _SpellPageState extends State<SpellPage> {
  final TextEditingController _textController = TextEditingController();
  SignBox signBox = const SignBox(image: null);
  String word = "";
  List<String> wordList = WordList.getWordList(maxLength: wordLength);

  int _index = 0;
  String letter = "";
  Timer? _timer;

  void _startTimer(String wrd) {
    _stopTimer();
    _index = 0;
    _lastLetter = "";
    _timer = Timer.periodic(Duration(milliseconds: (1000 / signSpeed).round()),
        (timer) {
      setState(() {
        // if _index is less than the length of the word, display the image for the letter at
        //  _index in the word
        if (_index < wrd.length) {
          bool offset = false;
          letter = wrd[_index];
          Image? image =
              letter.isEmpty ? null : Letters.currentLetters!.letters[letter];

          if (_lastLetter == letter && !lastOffset) {
            offset = true;
            lastOffset = true;
          } else {
            lastOffset = false;
          }

          setState(() {
            signBox = SignBox(image: image, offset: offset);
          });

          _lastLetter = letter;
          _index++;
        }
        // else
        else {
          signBox = const SignBox(image: null);
          timer.cancel();
        }
      }); // end setState
    });
  } // end _starttimer

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  } // end _stopTimer

  void generateNewWord() {
    word =
        WordList.validateWord(wordList[getRandom().nextInt(wordList.length)]);
  }

  @override
  Widget build(BuildContext context) {
    Widget inputRow = Row(
      children: <Widget>[
        Flexible(
          flex: 2,
          child: TextField(
            onSubmitted: (value) => confirmBtnPress(),
            controller: _textController,
            decoration: InputDecoration(
              hintText: getLang('pmtEnterText'),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: CustomButton(
            onPressed: () => signThisBtnPress(),
            child: Text(
              getLang('btnSignThis'),
              softWrap: false,
            ),
          ),
        ),
      ],
    );

    Widget btnRow = Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: CustomButton(
            onPressed: () => newWordBtnPress(),
            child: Text(getLang('btnNewWord')),
          ),
        ),
        Expanded(
          flex: 1,
          child: CustomButton(
            onPressed: () => signAgainBtnPress(),
            child: Text(getLang('btnSignAgain')),
          ),
        ),
        Expanded(
          flex: 1,
          child: CustomButton(
            onPressed: () => confirmBtnPress(),
            child: Text(getLang('btnConfirm')),
          ),
        ),
      ],
    );

    Widget changeSpeedRow = Row(
      children: [
        Expanded(
          flex: 2,
          child: Slider(
            value: signSpeed,
            min: 1,
            max: 7,
            divisions: 12,
            //label: "Signs / Second: ${signSpeed.toString()}",
            onChanged: (double value) {
              setState(() {
                signSpeed = value;
              });
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(child: Text(getLang('pmtSigningSpeed', [signSpeed]))),
        )
      ],
    );

    Widget changeLengthRow = Row(
      children: [
        Expanded(
          flex: 2,
          child: Slider(
            value: wordLength.toDouble(),
            min: 3,
            max: 7,
            divisions: 4,
            onChanged: (double value) {
              setState(() {
                int valueInt = value.toInt();
                wordLength = valueInt;
                wordList = WordList.getWordList(
                    maxLength: wordLength < 7 ? wordLength : 0);
              });
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
              child: Text(getLang('pmtWordLength',
                  [wordLength < 7 ? wordLength : '$wordLength+']))),
        )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: styledTitle(),
      ),
      body: PaddedScroll(
        context: context,
        children: [
          verticalPadding(child: signBox),
          verticalPadding(
              child: Center(
            child: Text(getLang('pmtSigningInfoLine', [
              correct == "Correct" ? word : getLang("strUnknown"),
              score,
            ])),
          )),
          verticalPadding(child: inputRow),
          verticalPadding(child: btnRow),
          verticalPadding(child: changeSpeedRow),
          verticalPadding(child: changeLengthRow),
          GoBackButton(context: context, exec: _stopTimer),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => helpBtnPress(context),
        tooltip: 'Help',
        child: const Icon(Icons.help),
      ),
    );
  }

  void helpBtnPress(BuildContext context) {
    Navigator.push(
        context, genRoute(SpellHelpPage(title: getLang('titleApp'))));
  }

  void signAgainBtnPress() => _startTimer(word);

  void newWordBtnPress() {
    _textController.text = "";
    generateNewWord();
    correct = "";
    _startTimer(word);
  }

  void signThisBtnPress() {
    _stopTimer();
    _startTimer(WordList.validateWord(_textController.text));
  }

  void confirmBtnPress() {
    _stopTimer();
    String text = _textController.text;
    text = WordList.validateWord(text);
    if (text == word) {
      setState(() {
        // Prevent infinite points from the same word
        if (word != wordLast) score++;
        wordLast = word;
        correct = "Correct";
        signBox = SignBox(image: Letters.currentLetters!.check);
      });
    } else {
      setState(() {
        correct = "Incorrect";
        signBox = SignBox(image: Letters.currentLetters!.cross);
      });
    } // end if / else
  } // end build

  @override
  void dispose() {
    super.dispose();
    _stopTimer();
  } // end dispose
} // end _SpellPageState

/* SPELL HELP */
class SpellHelpPage extends StatefulWidget {
  const SpellHelpPage({super.key, required this.title});
  final String title;
  @override
  State<SpellHelpPage> createState() => _SpellHelpPageState();
} // end SpellHelpPage

class _SpellHelpPageState extends State<SpellHelpPage> {
  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      verticalPaddingColumn(children: [
        Text(
          widget.title,
          textAlign: TextAlign.center,
          textScaler: TextScaler.linear(2),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        // main about
        // readFileWidget('assets/texts/spellhelp.md'),
        Marked(getLang('txtSpellingHelp')),
        GoBackButton(context: context),
      ])
    ];
    var paddedScroll = PaddedScroll(
      context: context,
      children: children,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: paddedScroll, // end body
    );
  } // end build
} // end _SpellHelpPageState
