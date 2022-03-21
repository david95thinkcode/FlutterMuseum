import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/models/Country.dart';
import 'package:museum/src/models/Museum.dart';
import 'package:museum/src/services/CountryService.dart';
import 'package:museum/src/services/MuseumService.dart';
import 'package:museum/src/styles.dart';

class CreateMuseumRoute extends StatefulWidget {
  const CreateMuseumRoute({Key? key}) : super(key: key);

  @override
  State<CreateMuseumRoute> createState() => _CreateMuseumRouteState();
}

class _CreateMuseumRouteState extends State<CreateMuseumRoute> {
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

  @override
  void initState() {
    super.initState();
    _databaser = Databaser();
    _museumService = MuseumService(_databaser);
    _countryService = CountryService(_databaser);
    _fetchCountries();
  }

  _fetchCountries() async {
    _countriesList = await _countryService.all();

    setState(() {
      _countriesListWidget = [];
      for (var x in _countriesList) {
        _countriesListWidget.add(Text(x.countryCode));
      }
    });
  }

  _getCountryAtIndex(int index) {
    if (_countriesList.isNotEmpty && index < _countriesList.length) {
      var selectedCountry = _countriesList[index];
      setState(() {
        _selectedCountry = selectedCountry;
        countryController.text = "${selectedCountry.countryName}";
      });
    }
  }

  _resetForm() {
    nameController.text = "";
    nbBookController.text = "0";
    countryController.text = "";
    _isSubmitting = false;
  }

  _formIsNotFilledCorrectly() {
    Fluttertoast.showToast(
        msg: "Erreur. Veuillez tout renseigner!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  _save() async {
    String name = nameController.text;
    int booksCount =
        nbBookController.text.isNotEmpty ? int.parse(nbBookController.text) : 0;

    setState(() {
      _isSubmitting = true;
    });
    var selectedCountry = _selectedCountry;
    if (selectedCountry != null && booksCount > 0 && name.isNotEmpty) {
      Museum museum = Museum(
          nomMus: name,
          nbLivres: booksCount,
          codePays: selectedCountry.countryCode
      );

      try {
        await _museumService.store(museum);
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
        title: const Text("Ajouter un Musée"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Expanded(
              child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
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
                                  labelText: 'Nom du musée (*)'),
                            )),
                        Padding(
                          padding: Styles.formfieldPadding,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: nbBookController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Entrez un nombre superieur a zéro',
                                labelText: 'Nombre de livres (*)'),
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
