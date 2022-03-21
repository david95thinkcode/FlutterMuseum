import 'dart:async';

import 'package:museum/src/models/Book.dart';
import 'package:museum/src/models/Country.dart';
import 'package:museum/src/models/Library.dart';
import 'package:museum/src/models/Museum.dart';
import 'package:museum/src/models/Visit.dart';
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
        join(path, '25museum_database.db'),
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
          nompays TEXT NOT NULL, 
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
        id integer PRIMARY KEY NOT NULL,
        nummus integer NOT NULL,
        isbn varchar NOT NULL,
        dateachat varchar
      )
    """;
  }

  static String sqlCreateVisitTable() {
    return """
    CREATE TABLE ${Visit.table}(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      firstname TEXT NOT NULL,
      lastname TEXT NOT NULL,
      nummus	INTEGER NOT NULL,
      jour	TEXT NOT NULL,
      nbvisiteurs	INTEGER DEFAULT 0
    )
    """;
  }

  Future<void> insertDefaultData(Database db) async {
    List<Country> countries = [
      const Country(countryCode: "bj", countryName: "Benin", nbHabitant: 12123200),
      const Country(countryCode: "cn", countryName: "China", nbHabitant: 1439323776),
      const Country(countryCode: "de", countryName: "Germany", nbHabitant: 83783942),
      const Country(countryCode: "gh", countryName: "Ghana", nbHabitant: 31072940),
      const Country(countryCode: "ke", countryName: "Kenya", nbHabitant: 53771296),
      const Country(countryCode: "ng", countryName: "Nigeria", nbHabitant: 206139589),
      const Country(countryCode: "ru", countryName: "Russia", nbHabitant: 145934462),
      const Country(countryCode: "tg", countryName: "Togo", nbHabitant: 8278724),
      const Country(countryCode: "us", countryName: "United States of America", nbHabitant: 331002651),
      const Country(countryCode: "za", countryName: "South Africa", nbHabitant: 59308690),
    ];

    // Museums list can be found here : https://en.wikipedia.org/wiki/Lists_of_museums
    List<Museum> museums = [
      const Museum(numMus: 1, nomMus: "Ecomuseum of Cocoa", nbLivres: 560, codePays: "gh"),
      const Museum(numMus: 2, nomMus: "Kwame Nkrumah University of Science and Technology Museum", nbLivres: 560, codePays: "gh"),
      const Museum(numMus: 3, nomMus: "Apache County Historical Society Museum", nbLivres: 36000, codePays: "us"),
      const Museum(numMus: 4, nomMus: "Junipero Serra Museum", nbLivres: 6000, codePays: "us"),
      const Museum(numMus: 5, nomMus: "Fort Jesus Museum, Mombasa", nbLivres: 3000, codePays: "ke"),
      const Museum(numMus: 6, nomMus: "Feodosia Money Museum", nbLivres: 6500, codePays: "ru"),
      const Museum(numMus: 7, nomMus: "Rozhdestveno Memorial Estate", nbLivres: 300, codePays: "ru"),
      const Museum(numMus: 8, nomMus: "Military Museum of the Chinese People's Revolution", nbLivres: 7800, codePays: "cn"),
      const Museum(numMus: 9, nomMus: "Musée en Plein Air de Parakou", nbLivres: 150, codePays: "bj"),
      const Museum(numMus: 10, nomMus: "Musée Régional d'Aného", nbLivres: 150, codePays: "tg"),
    ];

    List<Book> books = [
      const Book(
          isbn: "1944764046",
          title: "Neema Wants To Learn: A True Story Promoting Inclusion and Self-Determination",
          nbPages: 50,
          codePays: "us"
      ),
      const Book(
          isbn: "1539341151",
          title: "Special Delivery: Love Has No Bounds",
          nbPages: 40,
          codePays: "ru"
      ),
      const Book(
          isbn: "1546258922",
          title: "Neema Wants To Learn: A True Story Promoting Inclusion and Self-Determination",
          nbPages: 28,
          codePays: "gh"
      ),
      const Book(
          isbn: "9781696936545",
          title: "Super Science Squad: The Dragon's Toothache",
          nbPages: 38,
          codePays: "gh"
      ),
      const Book(
          isbn: "1973740036",
          title: "Tim & Gerald Ray Series: How Did He Get in There?",
          nbPages: 78,
          codePays: "ke"
      ),
      const Book(
          isbn: "138766848X",
          title: "Nathaniel English in the King of Video Games",
          nbPages: 34,
          codePays: "cn"
      ),
      const Book(
          isbn: "098644684X",
          title: "The Little Gnome",
          nbPages: 30,
          codePays: "us"
      ),
      const Book(
          isbn: "1492177563",
          title: "SNURTLE",
          nbPages: 52,
          codePays: "us"
      ),
      const Book(
          isbn: "1544780656",
          title: "Not Again! The Adventures of Breanna and Allyson",
          nbPages: 26,
          codePays: "us"
      ),
      const Book(
          isbn: "1941328148",
          title: "Adventurous Olivia's Allphabet Quest",
          nbPages: 67,
          codePays: "us"
      ),
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

    // Books
    for (var b in books) {
      db.insert(Book.table, b.toMap());
    }
  }
}
