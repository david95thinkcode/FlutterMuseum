import 'package:museum/contracts/Crudable.dart';
import 'package:museum/contracts/SBook.dart';
import 'package:museum/models/Book.dart';

class BookService implements Crudable, SBook {

  @override
  void delete(id) {
    // TODO: implement delete
  }

  @override
  void getAll() {
    // TODO: implement getAll
  }

  @override
  void getRecord(id) {
    // TODO: implement getRecord
  }

  @override
  void store(Book book) {
    // TODO: implement store
  }

  @override
  void update(Book book) {
    // TODO: implement update
  }

  @override
  List<Book> getAllFromCountry(String countryCode) {
    // TODO: implement getAllFromCountry
    throw UnimplementedError();
  }

}