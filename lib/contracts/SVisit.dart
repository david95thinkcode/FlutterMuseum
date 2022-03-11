import 'package:museum/models/Visit.dart';

abstract class SVisit {

  void store(Visit visit);

  void delete(int museumId);

  List<Visit> getAll();

  List<Visit> getAllAboutMuseum(int museumId);

  List<Visit> getAllBetweenDates(String startDate, String endDate);

  List<Visit> getAllBetweenDateAndMuseum(int museumId, String startDate, String endDate);

  List<Visit> getAllByDateAndMuseum(int museumId, String date) {
    return getAllBetweenDateAndMuseum(museumId, date, date);
  }
}