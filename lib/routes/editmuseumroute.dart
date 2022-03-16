import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:museum/config/databaser.dart';
import 'package:museum/models/Museum.dart';
import 'package:museum/services/MuseumService.dart';

class EditMuseumRoute extends StatefulWidget {
  const EditMuseumRoute({Key? key, required this.museum}) : super(key: key);
  final Museum museum;

  @override
  State<EditMuseumRoute> createState() => _EditMuseumRouteState();
}

class _EditMuseumRouteState extends State<EditMuseumRoute> {
  late Databaser _databaser;
  late MuseumService _museumService;
  final nameController = TextEditingController();
  final nbBookController = TextEditingController();
  final countryController = TextEditingController();
  bool _isSubmitting = false;
  late Museum _museum = widget.museum;

  @override
  void initState() {
    super.initState();
    _databaser = Databaser();
    _museumService = MuseumService(_databaser);
    _museum = widget.museum;
    _initForm();
  }

  _initForm() {
    setState(() {
        nameController.text = _museum.nomMus;
        nbBookController.text = _museum.nbLivres.toString();
        countryController.text = _museum.codePays;
    });
  }

  _save() async {
    String name = nameController.text;
    String country = countryController.text;
    int booksCount = nbBookController.text.isNotEmpty
        ? int.parse(nbBookController.text) : 0;

    Museum updateMuseum = Museum(numMus: _museum.numMus, nomMus: name, nbLivres: booksCount, codePays: country);
    setState(() {
      _isSubmitting = true;
    });

    try {
      await _museumService.update(updateMuseum);
      Fluttertoast.showToast(
          msg: "Enregistré",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.black,
          fontSize: 16.0
      );
    } catch(e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: "Echec d'enregistrement",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

    setState(() {
      _isSubmitting = false;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mettre a jour un Musée"),
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller: nameController,
                                      decoration: const InputDecoration(
                                          hintText: 'Entrez ici...',
                                          labelText: 'Nom du musée'
                                      ),
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: nbBookController,
                                      decoration: const InputDecoration(
                                          hintText: 'Entrez ici',
                                          labelText: 'Nombre de livres'
                                      ),
                                    ),
                                    TextFormField(
                                      controller: countryController,
                                      decoration: const InputDecoration(
                                          hintText: 'Entrez ici...',
                                          labelText: 'Pays'
                                      ),
                                    ),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.symmetric(vertical: 10),
                                              child: !_isSubmitting
                                                  ? ElevatedButton(
                                                child: const Text('Enregitrer'),
                                                onPressed: _save,
                                              )
                                                  : CircularProgressIndicator()
                                          ),
                                        ])
                                  ]
                              )
                          )
                      )
                    ],
                  )
              ),
            ],
          )
      ),
    );
  }
}
