import 'dart:async';
import 'package:aspell/classes/wordlist.dart';
import 'package:flutter/material.dart';
// custom
import 'package:aspell/options.dart';
import 'package:aspell/helpers_gui.dart';
import 'package:aspell/classes/widgets.dart';
import 'package:kittkatflutterlibrary/kittkatflutterlibrary.dart';

int counter = 0;
double signSpeed = 1;
int wordLength = 5;
int score = 0;
String wordLast = "";
int _lastLetter = -1;
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
  int imageID = 0;
  Timer? _timer;

  void _startTimer(String wrd) {
    _stopTimer();
    _index = 0;
    _lastLetter = -1;
    _timer = Timer.periodic(Duration(milliseconds: (1000 / signSpeed).round()),
        (timer) {
      setState(() {
        // if _index is less than the length of the word, display the image for the letter at
        //  _index in the word
        if (_index < wrd.length) {
          bool offset = false;
          imageID =
              wrd.codeUnitAt(_index) == 32 ? -1 : wrd.codeUnitAt(_index) - 65;
          Image? image = imageID == -1 ? null : images[imageID];

          if (_lastLetter == imageID && !lastOffset) {
            offset = true;
            lastOffset = true;
          } else {
            lastOffset = false;
          }

          setState(() {
            signBox = SignBox(image: image, offset: offset);
          });

          _lastLetter = imageID;
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
    word = wordList[getRandom().nextInt(wordList.length)]
        .toUpperCase()
        .replaceAll(RegExp(r'[^a-zA-Z]'), '');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (int i = 0; i < images.length; i++) {
      precacheImage(images[i].image, context);
    }
    precacheImage(check!.image, context);
    precacheImage(cross!.image, context);
  } // end didChangeDependencies

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
          child: customButton(
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
          child: customButton(
            onPressed: () => newWordBtnPress(),
            child: Text(getLang('btnNewWord')),
          ),
        ),
        Expanded(
          flex: 1,
          child: customButton(
            onPressed: () => signAgainBtnPress(),
            child: Text(getLang('btnSignAgain')),
          ),
        ),
        Expanded(
          flex: 1,
          child: customButton(
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
            min: 1,
            max: 7,
            divisions: 6,
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
        title: Text(getLang('titleApp')),
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
    Navigator.push(context, genRoute(const SpellHelpPage(title: title)));
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
    _startTimer(toLower(_textController.text));
  }

  void confirmBtnPress() {
    _stopTimer();
    String text = _textController.text;
    // TODO Remove toLower method
    text = toLower(text).toUpperCase();
    if (text == word) {
      setState(() {
        // Prevent infinite points from the same word
        if (word != wordLast) score++;
        wordLast = word;
        correct = "Correct";
        signBox = SignBox(image: check);
      });
    } else {
      setState(() {
        correct = "Incorrect";
        signBox = SignBox(image: cross);
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
      Text(
        widget.title,
        textAlign: TextAlign.center,
        textScaler: TextScaler.linear(2),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      // main about
      // readFileWidget('assets/texts/spellhelp.md'),
      Marked(getLang('txtSpellingHelp')),
      spacer,
      GoBackButton(context: context),
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
