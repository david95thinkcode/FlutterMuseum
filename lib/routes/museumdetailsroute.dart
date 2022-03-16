import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:museum/config/databaser.dart';
import 'package:museum/models/Museum.dart';
import 'package:museum/routes/editmuseumroute.dart';
import 'package:museum/services/MuseumService.dart';

class MuseumDetailsRoute extends StatefulWidget {
  const MuseumDetailsRoute({Key? key, required this.museum}) : super(key: key);
  final Museum museum;

  @override
  State<MuseumDetailsRoute> createState() => _MuseumDetailsRouteState();
}

class _MuseumDetailsRouteState extends State<MuseumDetailsRoute> {
  TextStyle textStyle =
      const TextStyle(fontSize: 35, fontWeight: FontWeight.bold);
  TextStyle _othertextStyle =
      const TextStyle(fontSize: 23, fontWeight: FontWeight.normal);

  _goToMuseumBooks() {}

  _goToMuseumVisits() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details du musée")),
      body: Container(
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.museum.nomMus, style: textStyle),
                      Text("Numero: " + widget.museum.numMus.toString(),
                          style: _othertextStyle),
                      Text("Pays: " + widget.museum.codePays,
                          style: _othertextStyle),
                      Text(
                        "Nombre de livres: " +
                            widget.museum.nbLivres.toString(),
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

                      // Container(
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Expanded(
                      //           child: ElevatedButton(
                      //               child: const Text('Visites'),
                      //               onPressed: () {
                      //                 _goToMuseumVisits();
                      //               })),
                      //       Expanded(
                      //           child: ElevatedButton(
                      //               child: const Text('Livres'),
                      //               onPressed: () {
                      //                 _goToMuseumBooks();
                      //               }))
                      //     ],
                      //   ),
                      // )
                    ],
                  )))),
    );
  }
}
