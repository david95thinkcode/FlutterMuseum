import 'dart:async';

import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/contracts/sqlitecrudable.dart';
import 'package:museum/src/models/Country.dart';
import 'package:sqflite/sqflite.dart';

class CountryService extends SQLiteCrudable {

  CountryService(Databaser databaser) : super(databaser);

  Future<void> store(Country country) async {
    await db.database.insert(
      Country.table,
      country.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,);
  }

  Future<bool> delete(String codePays) async {
    int affectedRowsCount = await db.database.delete(
      Country.table,
      where: 'codepays = ?',
      whereArgs: [codePays],
    );

    return affectedRowsCount > 0;
  }

  Future<List<Country>> all() async {
    final List<Map<String, dynamic>> maps = await db.database.query(Country.table);

    return List.generate(maps.length, (i) {
      return Country(
        countryCode: maps[i]['codepays'],
        countryName: maps[i]['nompays'],
        nbHabitant: maps[i]['nbhabitant']
      );
    });
  }

  @override
  void getAll() {
    print("Is database opened ${db.database.isOpen}");

  }

  @override
  Future<Country?> get(String countryCode) async {
    final List<Map<String, dynamic>> maps = await db.database.query(
        Country.table,
        where: 'codepays = ?',
        whereArgs: [countryCode]
    );

    if (maps.isNotEmpty) {
      return Country(
          countryCode: maps.first['codepays'],
          countryName: maps.first['nompays'],
          nbHabitant: maps.first['nbhabitant']
      );
    }
    return null;
  }

  Future<void> update(Country c) async {
    await db.database.update(
      Country.table,
      c.toMap(),
      where: 'codepays = ?',
      whereArgs: [c.countryCode],
    );

    return;
  }

}