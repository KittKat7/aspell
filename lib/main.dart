import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// custom
import 'package:aspell/helpers_gui.dart';
import 'package:aspell/pages/spelling_page.dart';
import 'package:aspell/pages/options_page.dart';
import 'package:aspell/classes/widgets.dart';
import 'package:aspell/classes/theme.dart';
import 'package:aspell/options.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadOptions();
  runApp(ChangeNotifierProvider<ThemeModel>(
      create: (context) => ThemeModel(),
      child: const MyApp(),
    )
  );
} // end main

/* ========== MYAPP ========== */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeModel>(context).updateTheme();
    return MaterialApp(
      title: 'ASpeLl',
      //theme: Provider.of<ThemeModel>(context).currentTheme,
      theme: Provider.of<ThemeModel>(context).currentTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(title: title),
        '/about': (context) => const AboutPage(title: "$title - About"),
        '/spell': (context) => const SpellPage(title: "$title - Spelling"),
        '/spell/help': (context) => const SpellHelpPage(title: "$title - Spelling: Help"),
        '/options':(context) => const OptionsPage(title: "$title - Options"),
      },
    );
  } // end build
} // end MyApp

/* ========== HOME PAGE ========== */
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
} // end HomePage

class _HomePageState extends State<HomePage> {
  
  @override
  void initState() {
    super.initState();
    loadWords();
    loadLetters();
  }
  
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, 
    var appBar = AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      title: GestureDetector(
        onTap: () { Provider.of<ThemeModel>(context,listen: false).setColorCyan(); saveOptions(); },
        child: Text(widget.title)
      )
    );
    // header text
    const headerTxt = Text(
      "ASpeLl",
      textScaleFactor: 5,
    );
    // spelling page button
    var spellBtn = ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/spell');
      },
      child: const Text("Start Spelling"),
    );
    // options page button
    var optionsBtn = ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/options');
      },
      child: const Text("App Settings"),
    );
    // about page button
    var aboutBtn = ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/about');
      },
      child: const Text("About $title"),
    );
    // spacer object
    var sideSpacer = const Expanded(flex: 0, child: SizedBox());
    // display the buttons
    var column = Column(children: <Widget>[
      Row(children: <Widget>[
        sideSpacer,
        Expanded(flex: 5, child: spellBtn),
        sideSpacer,
      ]),
      spacer,
      Row(children: <Widget>[
        sideSpacer,
        Expanded(flex: 5, child: optionsBtn),
        sideSpacer,
      ]),
      spacer,
      Row(children: <Widget>[
        sideSpacer,
        Expanded(flex: 5, child: aboutBtn),
        sideSpacer,
      ])
    ]);

    // return the page display
    return Scaffold(
      appBar: appBar,
      body: PaddedScroll(
        context: context,
        children: <Widget>[
        headerTxt,
        spacer,
        const Text(""), // sub heading text
        spacer,
        column,
      ]),
    );
  } // end build
} // end _HomePageState

/* ========== ABOUT PAGE ==========*/
/* ABOUT PAGE */
class AboutPage extends StatefulWidget {
  const AboutPage({super.key, required this.title});
  final String title;
  @override
  State<AboutPage> createState() => _AboutPageState();
} // and AboutPage

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PaddedScroll(
        context: context,
        children: children(context),
      )
    );
  }

  List<Widget> children(BuildContext context) {
    return <Widget>[
      Text(
        widget.title,
        textAlign: TextAlign.center,
        textScaleFactor: 2,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      // main about
      readFileWidget('assets/texts/about.md'),
      // spacer
      spacer,
      // back button
      GoBackButton(context: context),
    ];
  } // end build
} // end _AboutPageState


