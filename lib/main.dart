import 'package:aspell/classes/letter_signs.dart';
import 'package:aspell/classes/wordlist.dart';
import 'package:aspell/lang/en_us.dart';
import 'package:flutter/material.dart';
import 'package:kittkatflutterlibrary/kittkatflutterlibrary.dart';
// custom
import 'classes/options.dart';
import 'pages/home_page.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  setLangMap(en_us);
  await AppOptions.initialize();
  await WordList.loadWords();
  Letters.currentLetters = Letters(letterSet: AppOptions.letterSet);

  runApp(ThemedWidget(
    widget: const DefaultTextStyle(
      style: TextStyle(fontFamily: "Roboto"),
      child: MyApp(),
    ),
    theme: appTheme,
  ));
} // end main

/* ========== MYAPP ========== */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Letters.currentLetters!.cacheImages(context);
    // Provider.of<ThemeModel>(context).updateTheme();
    return MaterialApp(
      title: getLang('titleApp'),
      theme: appTheme.getThemeDataLight(context),
      darkTheme: appTheme.getThemeDataDark(context),
      themeMode: appTheme.getThemeMode(context),
      home: const HomePage(),
    );
  } // end build
} // end MyApp
