import 'package:museum/src/models/Museum.dart';

abstract class SMuseum {

  Future<List<Museum>> all();

  // Future<Museum> get(int numMus);

  Future<void> store(Museum museum);

  Future<void> update(Museum museum);

  Future<bool> delete(int numMus);
}