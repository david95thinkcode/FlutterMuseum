import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:museum/config/databaser.dart';
import 'package:museum/models/Book.dart';
import 'package:museum/models/Country.dart';
import 'package:museum/models/Museum.dart';
import 'package:museum/services/CountryService.dart';
import 'package:museum/services/BookService.dart';

class CreateBookRoute extends StatefulWidget {
  const CreateBookRoute({Key? key}) : super(key: key);

  @override
  State<CreateBookRoute> createState() => _CreateBookRouteState();
}

class _CreateBookRouteState extends State<CreateBookRoute> {
  late Databaser _databaser;
  late BookService _bookService;
  late CountryService _countryService;
  final _titleController = TextEditingController();
  final _isbnBookController = TextEditingController();
  final _nbPagesController = TextEditingController();
  final _countryController = TextEditingController();
  bool _isSubmitting = false;
  bool _shouldShowCountryPicker = false;
  Country? _selectedCountry;
  List<Country> _countriesList = [];
  List<Widget> _countriesListWidget = [];

  @override
  void initState() {
    super.initState();
    _databaser = Databaser();
    _bookService = BookService(_databaser);
    _countryService = CountryService(_databaser);
    _fetchCountries();
  }

  _fetchCountries() async {
    _countriesList = await _countryService.all();

    setState(() {
      _countriesListWidget = [];
      for (var x in _countriesList) {
        _countriesListWidget.add(Text(x.codePays));
      }
    });
  }

  _getCountryAtIndex(int index) {
    if (_countriesList.isNotEmpty && index < _countriesList.length) {
      var selectedCountry = _countriesList[index];
      setState(() {
        _selectedCountry = selectedCountry;
        _countryController.text = "${selectedCountry.codePays}";
      });
    }
  }

  _formIsNotFilledCorrectly() {
    Fluttertoast.showToast(
        msg: "Erreur. Veuillez bien tout renseigner!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  _save() async {
    int booksCount = _nbPagesController.text.isNotEmpty
        ? int.parse(_nbPagesController.text)
        : 0;

    setState(() {
      _isSubmitting = true;
    });
    var selectedCountry = _selectedCountry;
    if (selectedCountry != null && booksCount > 0 && _titleController.text.isNotEmpty && _isbnBookController.text.isNotEmpty) {
      Book book = Book(
          isbn: _isbnBookController.text,
          title: _titleController.text,
          nbPages: int.parse(_nbPagesController.text),
          codePays: _countryController.text
      );
      try {
        await _bookService.store(book);
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
        title: const Text("Ajouter un Ouvrage"),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 16),
                            child: TextFormField(
                              controller: _titleController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Entrez ici...',
                                  labelText: 'Titre (*)'),
                            )),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 16),
                            child: TextFormField(
                              controller: _isbnBookController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Entrez ici...',
                                  labelText: 'ISBN (*)'),
                            )),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _nbPagesController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Entrez un nombre superieur a zéro',
                                labelText: 'Nombre de pages (*)'),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 16),
                            child: TextFormField(
                              controller: _countryController,
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
