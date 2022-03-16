import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:museum/config/databaser.dart';
import 'package:museum/models/Museum.dart';
import 'package:museum/models/Visit.dart';
import 'package:museum/services/MuseumService.dart';
import 'package:museum/services/VisitService.dart';

class CreateVisitRoute extends StatefulWidget {
  const CreateVisitRoute({Key? key}) : super(key: key);

  @override
  State<CreateVisitRoute> createState() => _CreateVisitRouteState();
}

class _CreateVisitRouteState extends State<CreateVisitRoute> {
  late Databaser _databaser;
  late MuseumService _museumService;
  late VisitService _visitService;
  final nameController = TextEditingController();
  final nbVisiteurController = TextEditingController();
  final jourController = TextEditingController();
  bool _isSubmitting = false;
  String dropdownValue = '';
  List<Museum> _museumsList = [];

  @override
  void initState() {
    super.initState();
    _databaser = Databaser();
    _museumService = MuseumService(_databaser);
    _visitService = VisitService(_databaser);
    _fetchMuseum();
  }

  _fetchMuseum() async {
    _museumsList = await _museumService.all();
  }

  _resetForm() {
    nameController.text = "";
    nbVisiteurController.text = "0";
    jourController.text = "";
    _isSubmitting = false;
  }

  _save() async {
    String name = nameController.text;
    String jour = jourController.text;
    int visitorsCount = nbVisiteurController.text.isNotEmpty
        ? int.parse(nbVisiteurController.text)
        : 0;
    // TODO: pick musee from musee list
    Visit visit =
        Visit(nbVisiteurs: visitorsCount, numMus: int.parse(name), jour: jour);
    setState(() {
      _isSubmitting = true;
    });

    try {
      await _visitService.store(visit);
      _resetForm();
      Fluttertoast.showToast(
          msg: "Enregistré",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.black,
          fontSize: 16.0);
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: "Echec d'enregistrement",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0);
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
        title: const Text("Enregistrer visite"),
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        DropdownButton<String>(
                          value: null,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepOrange),
                          underline: Container(
                            height: 2,
                            color: Colors.deepOrangeAccent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>['One', 'Two', 'Free', 'Four']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                              hintText: 'Entrez ici...',
                              labelText: 'Nom du musée'),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: nbVisiteurController,
                          decoration: const InputDecoration(
                              hintText: 'Entrez ici',
                              labelText: 'Nombre de visiteurs'),
                        ),
                        TextFormField(
                          controller: jourController,
                          decoration: const InputDecoration(
                              hintText: 'Entrez ici...', labelText: 'Pays'),
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
                                      : CircularProgressIndicator()),
                            ])
                      ])))
            ],
          )),
        ],
      )),
    );
  }
}
