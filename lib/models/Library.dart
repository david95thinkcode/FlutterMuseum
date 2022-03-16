class Library {
  static String table = "library";
  final int id;
  final int numMus;
  final String isbn;
  final String dateAchat;

  const Library({
    required this.id,
      required this.numMus,
      required this.isbn,
      required this.dateAchat
  });
}
