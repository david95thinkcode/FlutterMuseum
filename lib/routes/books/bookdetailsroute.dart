import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:museum/config/databaser.dart';
import 'package:museum/models/Book.dart';
import 'package:museum/models/Museum.dart';
import 'package:museum/routes/editmuseumroute.dart';
import 'package:museum/services/MuseumService.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details de l'ouvrage")),
      body: Container(
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.book.title, style: textStyle),
                      Text(
                          "ISBN: " + widget.book.isbn,
                          style: _othertextStyle
                      ),
                      Text("Pays: " + widget.book.codePays,
                          style: _othertextStyle),
                      Text(
                        "Nombre de pages: " +
                            widget.book.nbPages.toString(),
                        style: _othertextStyle,
                        // textAlign: TextAlign.left,
                      ),
                      Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Retour")))
                    ],
                  )))),
    );
  }
}
