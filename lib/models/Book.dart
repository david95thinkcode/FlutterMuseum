class Book {
  late String _isbn;
  late String _title;
  int _nbPages = 0;
  late String _codePays;

  String get isbn => _isbn;

  set isbn(String value) {
    _isbn = value;
  }

  String get title => _title;

  String get codePays => _codePays;

  set codePays(String value) {
    _codePays = value;
  }

  int get nbPages => _nbPages;

  set nbPages(int value) {
    _nbPages = value;
  }

  set title(String value) {
    _title = value;
  }
}