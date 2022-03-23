import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/services/BookService.dart';
import 'package:museum/src/services/CountryService.dart';
import 'package:museum/src/services/LibraryService.dart';
import 'package:museum/src/services/MuseumService.dart';
import 'package:museum/src/services/VisitService.dart';

class Repository {

  late Databaser databaser;
  late BookService bookService;
  late MuseumService museumService;
  late LibraryService libraryService;
  late VisitService visitService;
  late CountryService countryService;

  Future<void> initialize() async {
    databaser = Databaser();
    await databaser.initDB();
      bookService = BookService(databaser);

      museumService = MuseumService(databaser);
      libraryService = LibraryService(databaser);
      countryService = CountryService(databaser);
      visitService = VisitService(databaser);

    print("REPOSITORY INITIALIZED");
    return;
  }

}
