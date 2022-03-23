import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:museum/src/config/databaser.dart';

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
  late Databaser _databaser;

  @override
  void initState() {
    _databaser = Databaser();
    _databaser.initDB().whenComplete(() async {
      print("Database Initialized!");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

    void _onVisitsPressed() {
      Navigator.pushNamed(context, "/visits");
    }

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
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text("Welcome to ${widget.title}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.pink),
                  ),
                ),
                Card(
                    elevation: 15.0,
                    color: Colors.yellow,
                    borderOnForeground: true,
                    child: InkWell(
                      onTap: () {
                        _onMuseumPressed();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            // const Image(image: AssetImage('assets/images/icons8-lumière-allumée-100.png'),),
                            Text(
                              "Musées",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    )
                ),
                Card(
                    elevation: 7.0,
                    color: Colors.brown,
                    borderOnForeground: true,
                    child: InkWell(
                      onTap: () {
                        _onLibraryPressed();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            // const Image(image: AssetImage('assets/images/icons8-lumière-allumée-100.png'),),
                            Text(
                              "Bibliothèque",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    )
                ),
                Card(
                    elevation: 15.0,
                    color: Colors.green,
                    borderOnForeground: true,
                    child: InkWell(
                      onTap: () {
                        _onBooksPressed();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            // const Image(image: AssetImage('assets/images/icons8-lumière-allumée-100.png'),),
                            Text(
                              "Ouvrages",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    )
                ),

                ElevatedButton(
                    style: _ansbtnStyle,
                    onPressed: () => {
                      _onCountryPressed()
                    },
                    child: Text("Pays")
                ),
                ElevatedButton(
                    style: _ansbtnStyle,
                    onPressed: _onVisitsPressed,
                    child: Text("Visites")
                )
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

