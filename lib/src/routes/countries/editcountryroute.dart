import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/models/Country.dart';
import 'package:museum/src/services/CountryService.dart';
import 'package:museum/src/styles.dart';

class EditCountryRoute extends StatefulWidget {
  const EditCountryRoute({Key? key, required this.country}) : super(key: key);
  final Country country;

  @override
  State<EditCountryRoute> createState() => _EditCountryRouteState();
}

class _EditCountryRouteState extends State<EditCountryRoute> {
  late Databaser _databaser;
  late CountryService _countryService;
  final _countryCodeController = TextEditingController();
  final _countryNameController = TextEditingController();
  final _nbHabitantController = TextEditingController();
  bool _isSubmitting = false;
  late Country _country = widget.country;

  @override
  void initState() {
    super.initState();
    _databaser = Databaser();
    _countryService = CountryService(_databaser);
    _country = widget.country;
    _initForm();
  }

  _formIsNotFilledCorrectly() {
    Fluttertoast.showToast(
        msg: "Erreur. Veuillez tout renseigner!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  _initForm() {
    setState(() {
      _countryCodeController.text = _country.countryCode;
      _countryNameController.text = _country.countryName;
      _nbHabitantController.text = _country.nbHabitant.toString();
    });
  }

  _save() async {
    setState(() {
      _isSubmitting = true;
    });
    if (_countryCodeController.text.isNotEmpty &&
        _countryNameController.text.isNotEmpty &&
        _nbHabitantController.text.isNotEmpty) {
      Country updatedCountry = Country(
          countryCode: _country.countryCode,
          countryName: _countryNameController.text,
          nbHabitant: int.parse(_nbHabitantController.text));
      try {
        await _countryService.update(updatedCountry);
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
        title: const Text("Mettre a jour un pays"),
        backgroundColor: Styles.menuCountryItemPrimaryColor,
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
                              controller: _countryCodeController,
                              readOnly: true,
                              enabled: false,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Entrez ici...',
                                  labelText: 'Code Pays (*)'),
                            )),
                        Padding(
                            padding: Styles.formfieldPadding,
                            child: TextFormField(
                              controller: _countryNameController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Entrez ici...',
                                  labelText: 'Nom complet du pays (*)'),
                            )),
                        Padding(
                          padding: Styles.formfieldPadding,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _nbHabitantController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Entrez un nombre superieur a zéro',
                                labelText: 'Nombre d\'habitants (*)'),
                          ),
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
