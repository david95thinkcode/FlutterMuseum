import '../models/Book.dart';

abstract class BookState {
  const BookState();
}

class BooksInitialState extends BookState {
  const BooksInitialState();
}

class BooksLoadingState extends BookState {
  const BooksLoadingState();
}

class BooksLoaded extends BookState {
  final List<Book> books;

  const BooksLoaded(this.books);

  @override
  bool operator == (Object o) {
    if (identical(this, o)) return true;

    return o is BooksLoaded && o.books == books;
  }

  @override
  int get hashCode => books.hashCode;
}