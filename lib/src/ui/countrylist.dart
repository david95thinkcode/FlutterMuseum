import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/models/Country.dart';
import 'package:museum/src/routes/countries/editcountryroute.dart';
import 'package:museum/src/services/CountryService.dart';

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
              // color: Colors.green[200],
              shadowColor: Colors.green,
              margin: const EdgeInsets.all(8),
              child: ListTile(
                  title: Text("${_list[index].countryName} (${_list[index].countryCode})"),
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
                            _deleteItem(_list[index].countryCode),
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
