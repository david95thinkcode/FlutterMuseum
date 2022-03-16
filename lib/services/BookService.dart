import 'package:museum/config/databaser.dart';
import 'package:museum/contracts/Crudable.dart';
import 'package:museum/contracts/SBook.dart';
import 'package:museum/contracts/sqlitecrudable.dart';
import 'package:museum/models/Book.dart';
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

  Future<bool> delete(String ISBN) async {
    int affectedRowsCount = await db.database.delete(
      Book.table,
      where: 'isbn = ?',
      whereArgs: [ISBN],
    );

    return affectedRowsCount > 0;
  }

  @override
  List<Book> getAllFromCountry(String countryCode) {
    // TODO: implement getAllFromCountry
    throw UnimplementedError();
  }
}