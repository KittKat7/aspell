import 'dart:async';
import 'package:flutter/material.dart';
// custom
import 'package:aspell/options.dart';
import 'package:aspell/helpers_gui.dart';
import 'package:aspell/classes/widgets.dart';
import 'package:kittkatflutterlibrary/kittkatflutterlibrary.dart';

int counter = 0;
double signSpeed = 1;
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
              wrd.codeUnitAt(_index) == 32 ? -1 : wrd.codeUnitAt(_index) - 97;
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
    Row inputRow = Row(
      children: <Widget>[
        Flexible(
          flex: 9,
          child: TextField(
            onSubmitted: (value) => confirmBtnPress(),
            controller: _textController,
            decoration: InputDecoration(
              hintText: getLang('pmtEnterText'),
            ),
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 5,
          child: ElevatedButton(
            onPressed: () => signThisBtnPress(),
            child: Text(getLang('btnSignThis')),
          ),
        ),
      ],
    );

    Row btnRow = Row(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: ElevatedButton(
            onPressed: () => newWordBtnPress(),
            child: Text(getLang('btnNewWord')),
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 4,
          child: ElevatedButton(
            onPressed: () => signAgainBtnPress(),
            child: Text(getLang('btnSignAgain')),
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 5,
          child: ElevatedButton(
            onPressed: () => confirmBtnPress(),
            child: Text(getLang('btnConfirm')),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(getLang('titleApp')),
      ),
      body: PaddedScroll(
        context: context,
        children: btnPanel(inputRow, btnRow, context),
      ), // end PaddedScroll
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
    word = wordList[getRandom().nextInt(wordList.length)];
    _startTimer(word);
  }

  void signThisBtnPress() {
    _stopTimer();
    _startTimer(toLower(_textController.text));
  }

  List<Widget> btnPanel(Row inputRow, Row btnRow, BuildContext context) {
    return <Widget>[
      signBox,
      spacer,
      Center(
        child: Text("Speed: $signSpeed - Score: $score - $correct"),
      ),
      Slider(
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
      inputRow,
      spacer,
      btnRow,
      spacer,
      GoBackButton(context: context, exec: _stopTimer),
    ];
  } // end build

  void confirmBtnPress() {
    _stopTimer();
    String text = _textController.text;
    text = toLower(text);
    if (text == word && word != wordLast) {
      wordLast = word;
      setState(() {
        score++;
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
        textScaleFactor: 2,
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
