import 'package:aspell/classes/options.dart';
import 'package:flutter/material.dart';

class Letters {
  static const letterPath = 'letters/';
  static const letterSets = [
    'ascii', // 'ascii' letters are normal english letters and are used for testing.
    'avery',
  ];

  static Letters? currentLetters;

  late Image check;
  late Image cross;
  Map<String, Image> letters;
  final String letterSet;

  Letters({required this.letterSet}) : letters = {} {
    for (int i = 'A'.codeUnitAt(0); i <= 'Z'.codeUnitAt(0); i++) {
      letters[String.fromCharCode(i)] = Image.asset(
          '$picturePath$letterPath$letterSet/${letterSet}_${String.fromCharCode(i).toLowerCase()}.png');
    }
    check = Image.asset("assets/pictures/check.png");
    cross = Image.asset("assets/pictures/cross.png");
  }

  void cacheImages(BuildContext context) {
    for (String l in letters.keys) {
      precacheImage(letters[l]!.image, context);
    }
    precacheImage(check.image, context);
    precacheImage(cross.image, context);
  }
}
