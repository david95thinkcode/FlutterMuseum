import 'package:museum/src/models/Visit.dart';

abstract class SVisit {

  void store(Visit visit);

  // void delete(int museumId);

  Future<List<Visit>> all();

  Future<List<Visit>> getMuseumVisits(int museumId);

  Future<List<Visit>> getAllBetweenDates(String startDate, String endDate);

  Future<List<Visit>> getAllBetweenDateAndMuseum(int museumId, String startDate, String endDate);

  Future<List<Visit>> getAllByDateAndMuseum(int museumId, String date) async {
    return await getAllBetweenDateAndMuseum(museumId, date, date);
  }
}