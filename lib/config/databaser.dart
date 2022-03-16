import 'dart:async';
import 'package:museum/models/Book.dart';
import 'package:museum/models/Country.dart';
import 'package:museum/models/Library.dart';
import 'package:museum/models/Museum.dart';
import 'package:museum/models/Visit.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Databaser {
  static final Databaser _databaser = Databaser._();
  Databaser._();
  late Database database;

  factory Databaser() {
      return _databaser;
  }

  Future<void> initDB() async {
    // Open the database and store the reference.
      String path = await getDatabasesPath();
      database = await openDatabase(
        join(path, 'bvmuseum_database.db'),
        onCreate: (db, version) async {
          await db.execute(sqlCreateCountryTable());
          await db.execute(sqlCreateBookTable());
          await db.execute(sqlCreateLibraryTable());
          await db.execute(sqlCreateMuseumTable());
          await db.execute(sqlCreateVisitTable());

          await insertDefaultData(db);
          print("====== DB INITED =======");
        },
        version: 1
    );
  }

  static String sqlCreateCountryTable() {
    return """
        CREATE TABLE ${Country.table} (
          codepays TEXT PRIMARY KEY NOT NULL UNIQUE, 
          nbhabitant INTEGER DEFAULT 0
        )
    """;
  }

  static String sqlCreateBookTable() {
    return """
      CREATE TABLE ${Book.table} (
        isbn TEXT PRIMARY KEY NOT NULL UNIQUE,
        nbpage INTEGER DEFAULT 0,
        titre	TEXT,
        codepays TEXT DEFAULT NULL
      )
    """;
  }

  static String sqlCreateMuseumTable() {
    return """
      CREATE TABLE ${Museum.table} (
        numMus INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nomMus TEXT NOT NULL,
        nblivres	INTEGER DEFAULT 0 ,
        codepays TEXT
      )
      """;
  }

  static String sqlCreateLibraryTable() {
    return """
      CREATE TABLE ${Library.table} (
        "id" integer PRIMARY KEY NOT NULL,
        "nummus" integer NOT NULL,
        "isbn" varchar NOT NULL,
        "dateachat" varchar
      )
    """;
  }

  static String sqlCreateVisitTable() {
    return """
    CREATE TABLE ${Visit.table}(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
      nummus	INTEGER NOT NULL,
      jour	TEXT NOT NULL,
      nbvisiteurs	INTEGER DEFAULT 0
    )
    """;
  }

  Future<void> insertDefaultData(Database db) async {
    List<Country> countries = [
      const Country(codePays: "bj", nbHabitant: 12123200),
      const Country(codePays: "cn", nbHabitant: 1439323776),
      const Country(codePays: "de", nbHabitant: 83783942),
      const Country(codePays: "gh", nbHabitant: 31072940),
      const Country(codePays: "ke", nbHabitant: 53771296),
      const Country(codePays: "ng", nbHabitant: 206139589),
      const Country(codePays: "ru", nbHabitant: 145934462),
      const Country(codePays: "tg", nbHabitant: 8278724),
      const Country(codePays: "us", nbHabitant: 331002651),
      const Country(codePays: "za", nbHabitant: 59308690),
    ];

    List<Museum> museums = [
      const Museum(numMus: 1, nomMus: "Musée de l'UNESCO", nbLivres: 560, codePays: "bj"),
      const Museum(numMus: 2, nomMus: "United State of America Museum", nbLivres: 36000, codePays: "us"),
    ];

    // ---- Insertions -----
    // Countries
    for (var c in countries) {
      await db.insert(Country.table, c.toMap());
    }

    // Museums
    for (var m in museums) {
      db.insert(Museum.table, m.toMap());
    }
  }
}
