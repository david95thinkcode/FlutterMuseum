import 'package:flutter/material.dart';
import 'package:museum/config/databaser.dart';
import 'package:museum/models/Country.dart';
import 'package:museum/services/CountryService.dart';
import 'package:museum/widgets/countrylist.dart';

class CountryHomeRoute extends StatefulWidget {
  const CountryHomeRoute({Key? key}) : super(key: key);

  @override
  State<CountryHomeRoute> createState() => _CountryHomeRouteState();
}

class _CountryHomeRouteState extends State<CountryHomeRoute> {
  late Databaser _databaser;
  late CountryService _countryService;
  late List<Country> list;

  void initState() {
    super.initState();
    _databaser = Databaser();
    _databaser.initDB().whenComplete(() async {
      _countryService = CountryService(_databaser);
      list = await _countryService.all();
    });
  }

  void _onFabPressed() {
    Navigator.pushNamed(context, "/countries/create");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Pays")
      ),
      body: const CountryList(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Ajouter",
        child: const Icon(Icons.add),
        onPressed: _onFabPressed,
      ),
    );
  }
}