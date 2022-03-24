import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/styles.dart';

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
    void _onCreditPressed() {
      Navigator.pushNamed(context, "/credit");
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
      body: GridView.count(
        padding: EdgeInsets.all(17.0),
        scrollDirection: Axis.horizontal,
        crossAxisCount: 2,
              children: [
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: Styles.menuItemElevation,
                    color: Styles.menuMuseumItemPrimaryColor,
                    borderOnForeground: true,
                    child: InkWell(
                      onTap: () {
                        _onMuseumPressed();
                      },
                      child: Padding(
                        padding: Styles.menuItemPadding,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(
                              width: Styles.menuIconWidth,
                                image: AssetImage('assets/images/british-museum.png')
                            ),
                            Text("Musées",
                              style: Styles.menuMuseumItemTextStyle,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    )
                ),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: Styles.menuItemElevation,
                    color: Styles.menuVisitItemPrimaryColor,
                    borderOnForeground: true,
                    child: InkWell(
                      onTap: () {
                        _onVisitsPressed();
                      },
                      child: Padding(
                        padding: Styles.menuItemPadding,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(
                                width: Styles.menuIconWidth,
                                image: AssetImage('assets/images/tour-guide.png')
                            ),
                            Text("Visites", style: Styles.menuTextStyle, textAlign: TextAlign.center,)
                          ],
                        ),
                      ),
                    )
                ),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: Styles.menuItemElevation,
                    color: Styles.menuLibraryItemPrimaryColor,
                    borderOnForeground: true,
                    child: InkWell(
                      onTap: () {
                        _onLibraryPressed();
                      },
                      child: Padding(
                        padding: Styles.menuItemPadding,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(
                                width: Styles.menuIconWidth,
                                image: AssetImage('assets/images/library.png')
                            ),
                            Text("Bibliothèque", style: Styles.menuTextStyle, textAlign: TextAlign.center,)
                          ],
                        ),
                      ),
                    )
                ),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: Styles.menuItemElevation,
                    color: Styles.menuBookItemPrimaryColor,
                    borderOnForeground: true,
                    child: InkWell(
                      onTap: () {
                        _onBooksPressed();
                      },
                      child: Padding(
                        padding: Styles.menuItemPadding,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(
                                width: Styles.menuIconWidth,
                                image: AssetImage('assets/images/books.png')
                            ),
                            Text("Ouvrages", style: Styles.menuTextStyle, textAlign: TextAlign.center)
                          ],
                        ),
                      ),
                    )
                ),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: Styles.menuItemElevation,
                    color: Styles.menuCountryItemPrimaryColor,
                    borderOnForeground: true,
                    child: InkWell(
                      onTap: ()  => _onCountryPressed(),
                      child: Padding(
                        padding: Styles.menuItemPadding,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(
                                width: Styles.menuIconWidth,
                                image: AssetImage('assets/images/countries.png')
                            ),
                            Text("Pays", style: Styles.menuTextStyle, textAlign: TextAlign.center)
                          ],
                        ),
                      ),
                    )
                ),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: Styles.menuItemElevation,
                    color: Colors.pink,
                    borderOnForeground: true,
                    child: InkWell(
                      onTap: () => _onCreditPressed(),
                      child: Padding(
                        padding: Styles.menuItemPadding,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(
                                width: Styles.menuIconWidth,
                                image: AssetImage('assets/images/poem.png')
                            ),
                            Text("Credits", style: Styles.menuTextStyle, textAlign: TextAlign.center)
                          ],
                        ),
                      ),
                    )
                ),
              ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

