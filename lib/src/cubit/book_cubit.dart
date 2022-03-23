import 'package:bloc/bloc.dart';
import 'package:museum/src/cubit/book_state.dart';
import 'package:museum/src/repositories/repository.dart';

class BookCubit extends Cubit<BookState> {

  final Repository _repository;

  BookCubit(this._repository) : super(const BooksInitialState());

  Future<void> getBooks() async {
    print("Getting from cubit");
    try {
      emit(const BooksLoadingState());
      final _books = await _repository.bookService.all();
      print(_books);
      emit(BooksLoaded(_books));
    } on Exception {
      print("Error");
    }
  }

}