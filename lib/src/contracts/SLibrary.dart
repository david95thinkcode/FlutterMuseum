import 'package:museum/src/models/Library.dart';

abstract class SLibrary {

  void store(Library library);

  void update(Library library);

  Library get(int museumId, String bookIsbn);

  List<Library> getAll();

  List<Library> getAllBetweenDates(String startDate, String endDate);

  List<Library> getAllBetweenDateAndMuseum(int museumId, String startDate, String endDate);

  List<Library> getAllByDateAndMuseum(int museumId, String date) {
    return getAllBetweenDateAndMuseum(museumId, date, date);
  }
}