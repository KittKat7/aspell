import 'package:flutter/services.dart';

class WordList {
  static List<String>? _rawWordList;

  static Future<void> loadWords() async {
    String text = await rootBundle.loadString('assets/texts/words.txt');
    _rawWordList = text.split('\n');
  }

  static List<String> getWordList({int maxLength = 0}) {
    return [
      for (String w in _rawWordList!)
        if (w.length <= maxLength || maxLength <= 0) w
    ];
  }
}
