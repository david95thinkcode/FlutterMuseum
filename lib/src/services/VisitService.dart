import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/contracts/SVisit.dart';
import 'package:museum/src/contracts/sqlitecrudable.dart';
import 'package:museum/src/models/Visit.dart';
import 'package:sqflite/sqflite.dart';

class VisitService extends SQLiteCrudable implements SVisit {
  VisitService(Databaser databaser) : super(databaser);

  @override
  Future<List<Visit>> all() async {
    final List<Map<String, dynamic>> maps = await db.database.query(Visit.table);

    return List.generate(maps.length, (i) {
      return Visit(
        numMus: maps[i]['nummus'],
        firstname: maps[i]['firstname'],
        lastname: maps[i]['lastname'],
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

  @override
  Future<bool> delete(Visit visit) async {
    int affectedRowsCount = await db.database.delete(
      Visit.table,
      where: 'nummus = ? and nbvisiteurs = ? and jour = ?',
      whereArgs: [visit.numMus, visit.nbVisiteurs, visit.jour],
    );

    return affectedRowsCount > 0;
  }

  @override
  Future<List<Visit>> getMuseumVisits(int museumId) async {
    List<Visit> _list = [];
    final List<Map<String, dynamic>> maps = await db.database.query(
      Visit.table,
      where: 'nummus = ?',
      whereArgs: [museumId]
    );

    _list = List.generate(maps.length, (i) {
      return Visit(
        numMus: maps[i]['nummus'],
        firstname: maps[i]['firstname'],
        lastname: maps[i]['lastname'],
        jour: maps[i]['jour'],
        nbVisiteurs: maps[i]['nbvisiteurs'],
      );
    });

    print(_list);

    return _list;
  }

  @override
  Future<List<Visit>> getAllBetweenDateAndMuseum(int museumId, String startDate, String endDate) {
    // TODO: implement getAllBetweenDateAndMuseum
    throw UnimplementedError();
  }

  @override
  Future<List<Visit>> getAllBetweenDates(String startDate, String endDate) {
    // TODO: implement getAllBetweenDates
    throw UnimplementedError();
  }

  @override
  Future<List<Visit>> getAllByDateAndMuseum(int museumId, String date) {
    // TODO: implement getAllByDateAndMuseum
    throw UnimplementedError();
  }
}
