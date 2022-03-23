import 'package:museum/src/models/Library.dart';
import 'package:museum/src/models/libe.dart';

abstract class SLibrary {

  void store(Library library);

  void update(Library library);

  Library get(int museumId, String bookIsbn);

  Future<List<Libe>> getMuseumLibrary(int museumId);

  List<Library> getAll();

  List<Library> getAllBetweenDates(String startDate, String endDate);

  List<Library> getAllBetweenDateAndMuseum(int museumId, String startDate, String endDate);

  List<Library> getAllByDateAndMuseum(int museumId, String date) {
    return getAllBetweenDateAndMuseum(museumId, date, date);
  }
}