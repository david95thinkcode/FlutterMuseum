class Library {
  late int _id;
  late int _numMus;
  late String _isbn;
  late String _dateAchat;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  int get numMus => _numMus;

  String get dateAchat => _dateAchat;

  set dateAchat(String value) {
    _dateAchat = value;
  }

  String get isbn => _isbn;

  set isbn(String value) {
    _isbn = value;
  }

  set numMus(int value) {
    _numMus = value;
  }
}