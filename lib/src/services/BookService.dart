import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/contracts/SBook.dart';
import 'package:museum/src/contracts/sqlitecrudable.dart';
import 'package:museum/src/models/Book.dart';
import 'package:museum/src/models/Library.dart';
import 'package:sqflite/sqflite.dart';

class BookService extends SQLiteCrudable implements SBook {
  BookService(Databaser databaser) : super(databaser);

  @override
  Future<List<Book>> all() async {
    final List<Map<String, dynamic>> maps = await db.database.query(Book.table);

    return List.generate(maps.length, (i) {
      return Book(
        title: maps[i]['titre'],
        isbn: maps[i]['isbn'],
        nbPages: maps[i]['nbpage'],
        codePays: maps[i]['codepays'],
      );
    });
  }

  @override
  Future<void> store(Book book) async {
    await db.database.insert(
      Book.table,
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> update(Book book) async {
    await db.database.update(
      Book.table,
      book.toMap(),
      where: 'isbn = ?',
      whereArgs: [book.isbn],
    );

    return;
  }

  @override
  Future<bool> delete(String ISBN) async {
    int affectedRowsCount = await db.database.delete(
      Book.table,
      where: 'isbn = ?',
      whereArgs: [ISBN],
    );

    return affectedRowsCount > 0;
  }

  @override
  Future<List<Book>> getAllFromCountry(String countryCode) async {
    List<Book> list = [];

    final List<Map<String, dynamic>> maps = await db.database
        .query(Book.table, where: 'codepays = ?', whereArgs: [countryCode]);
    list = List.generate(maps.length, (i) {
      return Book(
        title: maps[i]['titre'],
        isbn: maps[i]['isbn'],
        nbPages: maps[i]['nbpage'],
        codePays: maps[i]['codepays'],
      );
    });

    return list;
  }

  @override
  Future<List<Book>> getMuseumBooks(int museumId) async {
    List<Book> _list = [];
    print("Getting museum books");
    final List<Map<String, dynamic>> maps = await db.database.rawQuery("""
      SELECT * FROM ${Book.table}, ${Library.table}
      WHERE ${Library.table}.nummus = ${museumId}
      AND ${Library.table}.isbn = ${Book.table}.isbn
      """
    );

    _list = List.generate(maps.length, (i) {
      return Book(
        title: maps[i]['titre'],
        isbn: maps[i]['isbn'],
        nbPages: maps[i]['nbpage'],
        codePays: maps[i]['codepays'],
      );
    });

    return _list;
  }

}
