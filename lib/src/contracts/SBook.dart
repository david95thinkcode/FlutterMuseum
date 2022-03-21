import 'package:museum/src/models/Book.dart';

abstract class SBook {

  Future<List<Book>> all();

  Future<void> store(Book book);

  Future<void> update(Book book);

  Future<bool> delete(String ISBN);

  Future<List<Book>> getMuseumBooks(int museumId);

  Future<List<Book>> getAllFromCountry(String countryCode);
}