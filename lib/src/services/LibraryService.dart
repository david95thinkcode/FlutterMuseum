import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/contracts/SLibrary.dart';
import 'package:museum/src/contracts/sqlitecrudable.dart';
import 'package:museum/src/models/Book.dart';
import 'package:museum/src/models/Library.dart';
import 'package:museum/src/models/libe.dart';
import 'package:sqflite/sqflite.dart';

class LibraryService extends SQLiteCrudable implements SLibrary {
  LibraryService(Databaser databaser) : super(databaser);

  @override
  Future<List<Library>> all() async {
    final List<Map<String, dynamic>> maps = await db.database.query(Library.table);

    return List.generate(maps.length, (i) {
      return Library(
        id: maps[i]['id'],
        isbn: maps[i]['isbn'],
        numMus: maps[i]['nummus'],
        dateAchat: maps[i]['dateachat']
      );
    });
  }

  @override
  Future<void> store(Library lib) async {
    await db.database.insert(
      Library.table,
      lib.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> delete(int id) async {
    int affectedRowsCount = await db.database.delete(
      Library.table,
      where: 'id = ?',
      whereArgs: [id],
    );

    return affectedRowsCount > 0;
  }

  @override
  Library get(int museumId, String bookIsbn) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  List<Library> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  void update(Library library) {
    // TODO: implement update
  }

  @override
  List<Library> getAllBetweenDateAndMuseum(int museumId, String startDate, String endDate) {
    // TODO: implement getAllBetweenDateAndMuseum
    throw UnimplementedError();
  }

  @override
  List<Library> getAllBetweenDates(String startDate, String endDate) {
    // TODO: implement getAllBetweenDates
    throw UnimplementedError();
  }

  @override
  List<Library> getAllByDateAndMuseum(int museumId, String date) {
    // TODO: implement getAllByDateAndMuseum
    throw UnimplementedError();
  }

  @override
  Future<List<Libe>> getMuseumLibrary(int museumId) async {
    List<Libe> _list = [];
    final List<Map<String, dynamic>> maps = await db.database.rawQuery("""
      SELECT * FROM ${Book.table}, ${Library.table}
      WHERE ${Library.table}.nummus = ${museumId}
      AND ${Library.table}.isbn = ${Book.table}.isbn
      """
    );

    _list = List.generate(maps.length, (i) {
      return Libe(
          library: maps[i]['id'],
          museum: museumId,
          date: maps[i]['dateachat'],
          book: Book(
            title: maps[i]['titre'],
            isbn: maps[i]['isbn'],
            nbPages: maps[i]['nbpage'],
            codePays: maps[i]['codepays'],
          )
      );
    });

    return _list;
  }
}