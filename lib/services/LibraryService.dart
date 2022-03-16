import 'package:museum/config/databaser.dart';
import 'package:museum/contracts/SLibrary.dart';
import 'package:museum/contracts/sqlitecrudable.dart';
import 'package:museum/models/Library.dart';

class LibraryService extends SQLiteCrudable implements SLibrary {
  LibraryService(Databaser databaser) : super(databaser);


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
  void store(Library library) {
    // TODO: implement store
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
}