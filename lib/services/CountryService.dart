import 'dart:async';
import 'package:museum/config/databaser.dart';
import 'package:museum/contracts/sqlitecrudable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:museum/contracts/Crudable.dart';
import 'package:museum/models/Country.dart';

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

  Future<void> update(Country c) async {
    await db.database.update(
      Country.table,
      c.toMap(),
      where: 'codepays = ?',
      whereArgs: [c.codePays],
    );

    return;
  }

}