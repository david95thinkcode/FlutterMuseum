
class Museum {
  late int _numMus;
  String _nomMus = "";
  int _nbLivres = 0;
  late String _codePays;

  int get numMus => _numMus;

  set numMus(int value) {
    _numMus = value;
  }

  String get nomMus => _nomMus;

  String get codePays => _codePays;

  set codePays(String value) {
    _codePays = value;
  }

  int get nbLivres => _nbLivres;

  set nbLivres(int value) {
    _nbLivres = value;
  }

  set nomMus(String value) {
    _nomMus = value;
  }
}