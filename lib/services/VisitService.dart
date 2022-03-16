import 'package:museum/config/databaser.dart';
import 'package:museum/contracts/sqlitecrudable.dart';
import 'package:museum/models/Visit.dart';
import 'package:sqflite/sqflite.dart';

class VisitService extends SQLiteCrudable {
  VisitService(Databaser databaser) : super(databaser);

  @override
  Future<List<Visit>> all() async {
    final List<Map<String, dynamic>> maps = await db.database.query(Visit.table);

    return List.generate(maps.length, (i) {
      return Visit(
        numMus: maps[i]['nummus'],
        jour: maps[i]['jour'],
        nbVisiteurs: maps[i]['nbvisiteurs'],
      );
    });
  }

  @override
  Future<void> store(Visit visit) async {
    await db.database.insert(
      Visit.table,
      visit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // @override
  // Future<void> update(Visit visit) async {
  //   await db.database.update(
  //     Visit.table,
  //     visit.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [visit.id],
  //   );
  // }

  @override
  Future<bool> delete(Visit visit) async {
    int affectedRowsCount = await db.database.delete(
      Visit.table,
      where: 'nummus = ? and nbvisiteurs = ? and jour = ?',
      whereArgs: [visit.numMus, visit.nbVisiteurs, visit.jour],
    );

    return affectedRowsCount > 0;
  }

}