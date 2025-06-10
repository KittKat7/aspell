import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:aspell/options.dart';

/* ========== HELPERS ========== */
// vars
const Text spacer = Text("");
double paddingW = 0.1; // the percent of horiontal padding on each side
double paddingH = 0.05; // the amount of verticle padding on each side
double paddedW = 0; // the width of the available screen (excluding padding)
double paddedH = 0; // the height of the available screen (excluding padding)
double scale = 1; // not sure

var rBundle = rootBundle;

List<Image> images = [];
Image? check;
Image? cross;

Random _random = Random();

bool isDark = true;

Size getScreenSize(BuildContext context) {
  Size size = MediaQuery.of(context).size;

  double scaleH = size.height / 16;

  double scale = scaleH * 10;
  paddingW = (size.width - scale) / (size.width) / 2;
  if (paddingW < 0.1) {
    paddingW = 0.1;
  }
  return size;
}

double getPaddingW() {
  return paddedW;
}

double getPaddingH() {
  return paddedH;
}

Random getRandom() {
  return _random;
}

// Widget readFileWidget(String path) {
//   return FutureBuilder(
//     future: rootBundle.loadString(path),
//     builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//       if (snapshot.hasData) {
//         return MarkdownBody(
//           data: snapshot.data ?? "Could not load file",
//           onTapLink: (text, url, title) {
//             launchUrlString(url!);
//           },
//           //textAlign: TextAlign.justify,
//         );
//       } else {
//         return const CircularProgressIndicator();
//       } // if else
//     },
//   );
// } // end readFile

Widget signingBox(BuildContext context) {
  final screenSize = getScreenSize(context);
  return Container(
    width: (screenSize.width * (1 - paddingW * 2)),
    height: ((screenSize.width * (1 - paddingW * 2)) * 3 / 4),
    decoration: BoxDecoration(
        border: Border.all(
      color: Colors.black,
      width: 2,
    )),
  );
}

List<Image> loadLetters(/*BuildContext context*/) {
  List<String> strings = [];
  List<Image> imagess = [];
  for (int i = 0; i < 26; i++) {
    strings
        .add("${picturePath}letters/avery_${String.fromCharCode(97 + i)}.png");
    imagess.add(Image.asset(strings[i]));
    //precacheImage(AssetImage(strings[i]), context);
  } // end for
  images = imagess;
  check = Image.asset("assets/pictures/check.png");
  cross = Image.asset("assets/pictures/cross.png");
  return imagess;
} // end getLetters

String toLower(String str) {
  String uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  String acceptable = "abcdefghijklmnopqrstuvwxyz ";
  String string = "";
  for (int i = 0; i < str.length; i++) {
    if (uppercase.contains(str.substring(i, i + 1))) {
      string += str.substring(i, i + 1).toLowerCase();
    } else if (acceptable.contains(str.substring(i, i + 1))) {
      string += str.substring(i, i + 1);
    }
  }
  return string;
} // end toLower
