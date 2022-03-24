import 'package:flutter/material.dart';
import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/models/Country.dart';
import 'package:museum/src/routes/countries/editcountryroute.dart';
import 'package:museum/src/services/CountryService.dart';
import 'package:museum/src/styles.dart';
import 'package:museum/src/utils.dart';

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
    var deleteChoice = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Etes-vous certain de vouloir supprimer ce pays ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirmer'),
          ),
        ],
      ),
    );
    if (deleteChoice is bool) {
      if (deleteChoice == true) _onDeletionConfirmed(id);
    }
  }

  _onDeletionConfirmed(String id) async {
    bool done = await _countryService.delete(id);
    Utils.deletionSuccessToast(done, null);
    if (done) _refresh();
  }

  _editItem(Country country) {
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
      primary: true,
      appBar: AppBar(
          title: const Text("Pays"),
          backgroundColor: Styles.menuCountryItemPrimaryColor,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: _onFabPressed,
                child: const Icon(Icons.add_sharp, size: 26.0),
              )
          ),
        ],
      ),
      body: !_isLoading
          ? ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) =>
            Card(
              // shadowColor: Colors.green,
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
                            color: Colors.red,
                            onPressed: () => {
                              _deleteItem(_list[index].countryCode),
                            }
                        ),
                      ],
                    ),
                  )),
            ),
      )
          : const CircularProgressIndicator(),
    );
  }
}
