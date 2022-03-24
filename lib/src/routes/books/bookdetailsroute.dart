import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/models/Book.dart';
import 'package:museum/src/services/CountryService.dart';
import 'package:museum/src/styles.dart';

class BookDetailsRoute extends StatefulWidget {
  const BookDetailsRoute({Key? key, required this.book}) : super(key: key);
  final Book book;

  @override
  State<BookDetailsRoute> createState() => _BookDetailsRouteState();
}

class _BookDetailsRouteState extends State<BookDetailsRoute> {
  TextStyle textStyle =
      const TextStyle(fontSize: 35, fontWeight: FontWeight.bold);
  TextStyle _othertextStyle =
      const TextStyle(fontSize: 23, fontWeight: FontWeight.normal);
  late Databaser _databaser;
  late CountryService _countryService;
  String _countryLabel = "";

  @override
  void initState() {
    super.initState();
    _databaser = Databaser();
    _countryService = CountryService(_databaser);
    _initCountry();
  }

  _initCountry() async {
    var f = await _countryService.get(widget.book.codePays);
    if (f != null) {
      setState(() {
        _countryLabel = f.countryName;
      });
    } else {
      _countryLabel = widget.book.codePays;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details de l'ouvrage"), backgroundColor: Styles.menuBookItemPrimaryColor,),
      body: Container(
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(widget.book.title, style: textStyle, textAlign: TextAlign.center),
                      Text("ISBN: ${widget.book.isbn}", style: _othertextStyle),
                      Text("Pays: ${_countryLabel}", style: _othertextStyle),
                      Text("Nombre de pages: ${widget.book.nbPages.toString()}", style: _othertextStyle,),
                      Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Retour")))
                    ],
                  )))),
    );
  }
}
