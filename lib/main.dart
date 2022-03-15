import 'package:flutter/material.dart';
import 'package:museum/routes/museumhomeroute.dart';
import 'package:museum/routes/libraryhomeroute.dart';
import 'package:museum/routes/bookhomeroute.dart';
import 'package:museum/routes/countryhomeroute.dart';
import 'package:museum/routes/createvisitroute.dart';
import 'package:museum/routes/createmuseumroute.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Museum App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: "My Museum"),
        '/museums': (context) => const MuseumHomeRoute(),
        '/museums/create': (context) => const CreateMuseumRoute(),
        '/libraries': (context) => const LibraryHomeRoute(),
        '/books': (context) => const BookHomeRoute(),
        '/countries': (context) => const CountryHomeRoute(),
        '/visits/create': (context) => const CreateVisitRoute(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ButtonStyle _ansbtnStyle =
  ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20)
  );

  @override
  void initState() {
    // TODO:
  }

  void _onFabPressed() {
    Navigator.pushNamed(context, "/visits/create");
  }

  void _onMuseumPressed() {
    Navigator.pushNamed(context, "/museums");
  }

  void _onLibraryPressed() {
    Navigator.pushNamed(context, "/libraries");
  }

  void _onBooksPressed() {
    Navigator.pushNamed(context, "/books");
  }

  void _onCountryPressed() {
    Navigator.pushNamed(context, "/countries");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                ElevatedButton(
                    style: _ansbtnStyle,
                    onPressed: () => {
                      _onMuseumPressed()
                    },
                    child: const Text("Museum")
                ),
                ElevatedButton(
                    style: _ansbtnStyle,
                    onPressed: () => {
                      _onLibraryPressed()
                    },
                    child: const Text("Bibliothèque")
                ),
                ElevatedButton(
                    style: _ansbtnStyle,
                    onPressed: () => {
                      _onBooksPressed()
                    },
                    child: const Text("Ouvrage")
                ),
                ElevatedButton(
                    style: _ansbtnStyle,
                    onPressed: () => {
                      _onCountryPressed()
                    },
                    child: Text("Pays")
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFabPressed,
        tooltip: 'Nouvelle visite',
        child: const Icon(Icons.add_sharp),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
