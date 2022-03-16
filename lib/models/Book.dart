class Book {
  static String table = "book";
  final String isbn;
  final String title;
  final int nbPages;
  final String codePays;

  const Book({
    required this.isbn,
    required this.title,
    required this.nbPages,
    required this.codePays
  });
}
