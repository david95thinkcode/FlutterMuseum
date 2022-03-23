import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/models/Museum.dart';
import 'package:museum/src/models/Visit.dart';
import 'package:museum/src/services/MuseumService.dart';
import 'package:museum/src/services/VisitService.dart';

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
  final timeController = TextEditingController();
  final nbVisiteurController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  bool _isSubmitting = false;
  Museum? _selectedMuseum;
  DateTime _selectedDate = DateTime.now();
  List<Museum> _museumsList = [];
  List<Widget> _museumListWidget = [];
  bool _shouldShowMuseumPicker = false;
  bool _shouldShowDatePicker = false;

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

    setState(() {
      _museumListWidget = [];
      for (var x in _museumsList) {
        _museumListWidget.add(Text(x.nomMus));
      }
    });
    // print(_museumsList);
  }

  _getMuseumAtIndex(int index) {
    if (_museumsList.isNotEmpty && index < _museumsList.length) {
      var selectedMuseum = _museumsList[index];
      setState(() {
        _selectedMuseum = selectedMuseum;
        nameController.text = selectedMuseum.nomMus;
      });
    }
  }

  _resetForm() {
    nameController.text = "";
    _firstnameController.text = "";
    _lastnameController.text = "";
    _isSubmitting = false;
  }

  _formIsNotFilledCorrectly() {
    Fluttertoast.showToast(
        msg: "Erreur. Veuillez tout renseigner!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  _save() async {
    int visitorsCount = nbVisiteurController.text.isNotEmpty
        ? int.parse(nbVisiteurController.text)
        : 0;
    var selectedMuseum = _selectedMuseum;

    if (selectedMuseum == null || _firstnameController.text.isEmpty || _lastnameController.text.isEmpty || nameController.text.isEmpty) {
      _formIsNotFilledCorrectly();
    } else {
      Visit visit = Visit(
          firstname: _firstnameController.text,
          lastname: _lastnameController.text,
          numMus: selectedMuseum.numMus!,
          jour: _selectedDate.toString(),
          nbVisiteurs: visitorsCount
      );
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
  }

  _onDatePicked(DateTime time) {
    setState(() {
      _selectedDate = time;
      timeController.text = DateFormat.yMMMd().format(_selectedDate);
    });
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
          Container(
              child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: TextFormField(
                            controller: nameController,
                            readOnly: true,
                            onTap: () {
                              if (_museumsList.isNotEmpty && _selectedMuseum == null) {
                                _getMuseumAtIndex(0);
                              }
                              setState(() {
                                _shouldShowMuseumPicker =
                                    !_shouldShowMuseumPicker;
                              });
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                // hintText: 'Entrez ici...',
                                labelText: 'Nom du musée'),
                          ),
                        ),
                        Visibility(
                          visible: _shouldShowMuseumPicker,
                          child: Container(
                              height: 130,
                              child: CupertinoPicker(
                                children: _museumListWidget,
                                onSelectedItemChanged: (value) {
                                  _getMuseumAtIndex(value);
                                },
                                itemExtent: 25,
                                diameterRatio: 1,
                                useMagnifier: true,
                                magnification: 1,
                                looping: true,
                              )),
                        ),
                        // Padding(
                        //     padding: EdgeInsets.symmetric(
                        //         horizontal: 8, vertical: 16),
                        //     child: TextFormField(
                        //       keyboardType: TextInputType.number,
                        //       controller: nbVisiteurController,
                        //       decoration: const InputDecoration(
                        //           border: OutlineInputBorder(),
                        //           hintText: 'Entrez ici',
                        //           labelText: 'Nombre de visiteurs'),
                        //       onTap: () {
                        //         setState(() {
                        //           _shouldShowMuseumPicker = false;
                        //         });
                        //       },
                        //     )
                        // ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller: _lastnameController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Entrez ici',
                                      labelText: 'Nom du visiteur'),
                                  onTap: () {
                                    setState(() {
                                      _shouldShowMuseumPicker = false;
                                    });
                                  },
                                ),

                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller: _firstnameController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Entrez ici',
                                      labelText: 'Prénom du visiteur'
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _shouldShowMuseumPicker = false;
                                    });
                                  },
                                )
                            ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: TextFormField(
                            controller: timeController,
                            readOnly: true,
                            // initialValue: _selectedDate.toString(),
                            onTap: () {
                              if (timeController.text.isEmpty) {
                                _onDatePicked(DateTime.now());
                              }
                              setState(() {
                                _shouldShowDatePicker = !_shouldShowDatePicker;
                              });
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Touchez pour changer...',
                                labelText: 'Date de la visite'),
                          ),
                        ),
                        Visibility(
                          visible: _shouldShowDatePicker,
                          child: Container(
                            height: 200,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              initialDateTime: _selectedDate,
                              onDateTimeChanged: (DateTime newDateTime) {
                                _onDatePicked(newDateTime);
                              },
                            ),
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: !_isSubmitting
                                      ? ElevatedButton(
                                          child: const Text('Enregistrer'),
                                          onPressed: _save,
                                        )
                                      : CircularProgressIndicator()),
                            ]),
                      ])))
            ],
          )),
        ],
      )),
    );
  }
}
