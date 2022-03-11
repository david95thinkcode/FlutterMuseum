import 'package:museum/models/Book.dart';

abstract class SBook {

  void store(Book book);

  void update(Book book);

  List<Book> getAllFromCountry(String countryCode);
}