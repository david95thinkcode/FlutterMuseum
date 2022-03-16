import 'dart:async';
import 'package:museum/config/databaser.dart';
import 'package:museum/contracts/sqlitecrudable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:museum/contracts/Crudable.dart';
import 'package:museum/models/Country.dart';

class CountryService extends SQLiteCrudable implements Crudable {

  CountryService(Databaser databaser) : super(databaser);

  void store(Country country) async {
    await db.database.insert(Country.table, country.toMap());
  }

  @override
  void delete(id) {
    // TODO: implement delete
  }

  Future<List<Country>> all() async {
    final List<Map<String, dynamic>> maps = await db.database.query(Country.table);

    return List.generate(maps.length, (i) {
      return Country(
        codePays: maps[i]['codepays'],
        nbHabitant: maps[i]['nbhabitant']
      );
    });
  }

  @override
  void getAll() {
    print("Is database opened ${db.database.isOpen}");

  }

  @override
  void getRecord(id) {
    // TODO: implement getRecord
  }

  @override
  void update(id) {
    // TODO: implement update
  }

}