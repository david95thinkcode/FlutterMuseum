import 'package:museum/models/Museum.dart';

abstract class SMuseum {

  void store(Museum museum);

  void update(Museum museum);
}