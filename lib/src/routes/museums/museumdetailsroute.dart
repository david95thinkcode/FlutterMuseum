import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/models/Museum.dart';
import 'package:museum/src/services/CountryService.dart';

class MuseumDetailsRoute extends StatefulWidget {
  const MuseumDetailsRoute({Key? key, required this.museum}) : super(key: key);
  final Museum museum;
  @override
  State<MuseumDetailsRoute> createState() => _MuseumDetailsRouteState();
}

class _MuseumDetailsRouteState extends State<MuseumDetailsRoute> {
  TextStyle textStyle =
      const TextStyle(fontSize: 35, fontWeight: FontWeight.bold);
  final TextStyle _othertextStyle =
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
    var f = await _countryService.get(widget.museum.codePays);
    if (f != null) {
      setState(() {
        _countryLabel = f.countryName;
      });
    } else {
      _countryLabel = widget.museum.codePays;
    }
  }

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
                      Text(widget.museum.nomMus, style: textStyle, textAlign: TextAlign.center),
                      Text("Numero: ${widget.museum.numMus.toString()}",
                          style: _othertextStyle),
                      Text("Pays: ${_countryLabel}",
                          style: _othertextStyle),
                      Text("Nombre de livres: ${widget.museum.nbLivres.toString()}",
                        style: _othertextStyle,
                      ),
                      Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Retour")
                          )
                      ),
                    ],
                  )))),
    );
  }
}
