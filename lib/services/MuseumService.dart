import 'package:museum/config/databaser.dart';
import 'package:museum/contracts/SMuseum.dart';
import 'package:museum/contracts/sqlitecrudable.dart';
import 'package:museum/models/Museum.dart';
import 'package:sqflite/sqflite.dart';

class MuseumService extends SQLiteCrudable implements SMuseum {
  MuseumService(Databaser databaser) : super(databaser);

  // @override
  // Future<Museum> get(int numMus) async {
  //   // TODO: implement getRecord
  //
  //   return Museum(numMus: numMus, nomMus: nomMus, nbLivres: nbLivres, codePays: codePays);
  // }

  /*
    List<Map> maps = await db.query(tableTodo,
        columns: [columnId, columnDone, columnTitle],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Todo.fromMap(maps.first);
    }
    return null;

   */

  @override
  Future<List<Museum>> all() async {
    final List<Map<String, dynamic>> maps = await db.database.query(Museum.table);

    return List.generate(maps.length, (i) {
      return Museum(
        numMus: maps[i]['numMus'],
        nomMus: maps[i]['nomMus'],
        nbLivres: maps[i]['nblivres'],
        codePays: maps[i]['codepays'],
      );
    });
  }

  @override
  Future<void> store(Museum museum) async {
    await db.database.insert(
        Museum.table,
        museum.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> update(Museum museum) async {
    await db.database.update(
      Museum.table,
      museum.toMap(),
      where: 'numMus = ?',
      whereArgs: [museum.numMus],
    );
  }

  @override
  Future<bool> delete(int numMus) async {
    int affectedRowsCount = await db.database.delete(
      Museum.table,
      where: 'numMus = ?',
      whereArgs: [numMus],
    );

    return affectedRowsCount > 0;
  }

}