import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:museum/config/databaser.dart';
import 'package:museum/models/Book.dart';
import 'package:museum/models/Country.dart';
import 'package:museum/routes/books/editbookroute.dart';
import 'package:museum/routes/countries/editcountryroute.dart';
import 'package:museum/services/BookService.dart';
import 'package:museum/services/CountryService.dart';

class CountryList extends StatefulWidget {
  const CountryList({Key? key}) : super(key: key);

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  late Databaser _databaser;
  late CountryService _countryService;
  late List<Country> _list;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _list = [];
    _databaser = Databaser();
    _countryService = CountryService(_databaser);
    _refresh();
  }

  void _refresh() async {
    _isLoading = true;
    final data = await _countryService.all();
    setState(() {
      _list = data;
    });
    _isLoading = false;
  }

  _deleteItem(String id) async {
    //
    bool done = await _countryService.delete(id);

      Fluttertoast.showToast(
          msg: done ? "Supprimé" : "Echec de suppression. Réessayez",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: done ? Colors.greenAccent : Colors.redAccent,
          textColor: done ? Colors.black : Colors.white,
          fontSize: 16.0
      );

      if (done) {
        _refresh();
      }
  }

  _editItem(Country country) {
    print(country);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCountryRoute(country: country),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) =>
            Card(
              color: Colors.orange[200],
              margin: const EdgeInsets.all(15),
              child: ListTile(
                  title: Text("${_list[index].codePays} - ${_list[index].nbHabitant} habitants"),
                  // subtitle: Text("${_list[index].nbHabitant} habitants"),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => {
                            _editItem(_list[index])
                          }
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => {
                            _deleteItem(_list[index].codePays),
                          }
                        ),
                      ],
                    ),
                  )),
            ),
        )
    : CircularProgressIndicator();
  }
}