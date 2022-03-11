class Visit {
  late int _id;
  late int _numMus;
  late String _jour;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  int get numMus => _numMus;

  String get jour => _jour;

  set jour(String value) {
    _jour = value;
  }

  set numMus(int value) {
    _numMus = value;
  }
}