import 'package:museum/config/databaser.dart';

abstract class Crudable {

  void getAll();

  void getRecord(dynamic id);

  void delete(dynamic id);
}