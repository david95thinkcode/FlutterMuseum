
import 'package:museum/config/databaser.dart';

class SQLiteCrudable {
  late Databaser db;

  SQLiteCrudable(Databaser databaser) {
    db = databaser;
  }
}