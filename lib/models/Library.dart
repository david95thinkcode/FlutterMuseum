class Library {
  static String table = "library";
  final int? id;
  final int numMus;
  final String isbn;
  final String dateAchat;

  const Library({
      this.id,
      required this.numMus,
      required this.isbn,
      required this.dateAchat
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nummus': numMus,
      'isbn': isbn,
      'dateachat': dateAchat
    };
  }

  @override
  String toString() {
    return 'Library{id: $id, numMus: $numMus, isbn: $isbn, dateAchat: $dateAchat}';
  }
}
