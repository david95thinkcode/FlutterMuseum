import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/models/Country.dart';
import 'package:museum/src/models/Museum.dart';
import 'package:museum/src/services/CountryService.dart';
import 'package:museum/src/services/MuseumService.dart';
import 'package:museum/src/styles.dart';

class EditMuseumRoute extends StatefulWidget {
  const EditMuseumRoute({Key? key, required this.museum}) : super(key: key);
  final Museum museum;

  @override
  State<EditMuseumRoute> createState() => _EditMuseumRouteState();
}

class _EditMuseumRouteState extends State<EditMuseumRoute> {
  late Databaser _databaser;
  late MuseumService _museumService;
  late CountryService _countryService;
  final nameController = TextEditingController();
  final nbBookController = TextEditingController();
  final countryController = TextEditingController();
  bool _isSubmitting = false;
  bool _shouldShowCountryPicker = false;
  Country? _selectedCountry;
  List<Country> _countriesList = [];
  List<Widget> _countriesListWidget = [];
  late Museum _museum = widget.museum;

  @override
  void initState() {
    super.initState();
    _databaser = Databaser();
    _museumService = MuseumService(_databaser);
    _countryService = CountryService(_databaser);
    _fetchCountries();
    _museum = widget.museum;
    _initForm();
  }

  _fetchCountries() async {
    _countriesList = await _countryService.all();

    setState(() {
      _countriesListWidget = [];
      for (var x in _countriesList) {
        _countriesListWidget.add(Text(x.countryCode));
      }
      _selectedCountry = _getCountryWithCode(_museum.codePays);
    });
  }

  Country _getCountryWithCode(String countryCode) {
    Country c = _countriesList.firstWhere((element) => element.countryCode == countryCode);
    return c;
  }

  _getCountryAtIndex(int index) {
    if (_countriesList.isNotEmpty && index < _countriesList.length) {
      var selectedCountry = _countriesList[index];
      setState(() {
        _selectedCountry = selectedCountry;
        countryController.text = selectedCountry.countryName;
      });
    }
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

  _initForm() {
    setState(() {
      nameController.text = _museum.nomMus;
      nbBookController.text = _museum.nbLivres.toString();
      countryController.text = _museum.codePays;
      // Country e = _selectedCountry;
      // if (e != null) {
      //   countryController.text = e.countryName;
      // }
    });
  }

  _save() async {
    setState(() {
      _isSubmitting = true;
    });

    String name = nameController.text;
    int booksCount =
        nbBookController.text.isNotEmpty ? int.parse(nbBookController.text) : 0;
    var selectedCountry = _selectedCountry;
    if (selectedCountry != null && booksCount > 0 && name.isNotEmpty) {
      Museum updateMuseum = Museum(
          numMus: _museum.numMus,
          nomMus: name,
          nbLivres: booksCount,
          codePays: selectedCountry.countryCode);

      try {
        await _museumService.update(updateMuseum);
        Fluttertoast.showToast(
            msg: "Enregistré",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 16.0);
        Navigator.pop(context);
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
    } else {
      _formIsNotFilledCorrectly();
    }

    setState(() {
      _isSubmitting = false;
    });
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Padding(
                            padding: Styles.formfieldPadding,
                            child: TextFormField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Entrez ici...',
                                  labelText: 'Nom du musée'),
                            )),
                        Padding(
                          padding: Styles.formfieldPadding,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: nbBookController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Entrez ici',
                                labelText: 'Nombre de livres'),
                          ),
                        ),
                        Padding(
                            padding: Styles.formfieldPadding,
                            child: TextFormField(
                              controller: countryController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                  hintText: 'Touchez pour changer',
                                  border: OutlineInputBorder(),
                                  labelText: 'Pays'),
                              onTap: () {
                                setState(() {
                                  _shouldShowCountryPicker =
                                      !_shouldShowCountryPicker;
                                });
                              },
                            )),
                        Visibility(
                          visible: _shouldShowCountryPicker,
                          child: Container(
                              height: 130,
                              child: CupertinoPicker(
                                children: _countriesListWidget,
                                onSelectedItemChanged: (value) {
                                  _getCountryAtIndex(value);
                                },
                                itemExtent: 25,
                                diameterRatio: 1,
                                useMagnifier: true,
                                magnification: 1.1,
                                looping: true,
                              )),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
