import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/models/Country.dart';
import 'package:museum/src/routes/countries/editcountryroute.dart';
import 'package:museum/src/services/CountryService.dart';

class CountryHomeRoute extends StatefulWidget {
  const CountryHomeRoute({Key? key}) : super(key: key);

  @override
  State<CountryHomeRoute> createState() => _CountryHomeRouteState();
}

class _CountryHomeRouteState extends State<CountryHomeRoute> {
  late Databaser _databaser;
  late CountryService _countryService;
  late List<Country> _list;
  bool _isLoading = false;

  void initState() {
    super.initState();
    _list = [];
    _databaser = Databaser();
    _countryService = CountryService(_databaser);
    _refresh();
  }

  void _onFabPressed() {
    Navigator.pushNamed(context, "/countries/create").then((value) {
      _refresh();
    });
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
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => EditCountryRoute(country: country),
      ),
    ).then((value) {
      _refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Pays")
      ),
      body: !_isLoading
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
          : CircularProgressIndicator(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Ajouter",
        child: const Icon(Icons.add),
        onPressed: _onFabPressed,
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked
    );
  }
}