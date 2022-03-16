import 'package:flutter/material.dart';
import 'package:museum/config/databaser.dart';
import 'package:museum/models/Country.dart';
import 'package:museum/services/CountryService.dart';

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
      // Country c = Country(codePays: "bj", nbHabitant: 1200000);
      // _countryService.store(c);
      list = await _countryService.all();
      print("List of countries ${list.length}");
      print(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Countries home"),
      ),
      body: Center(
        child: Column(
          children: const <Widget>[
            Text("Countries home")
          ],
        ),
      ),
    );
  }
}