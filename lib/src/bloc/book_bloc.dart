import 'dart:async';

import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/models/Book.dart';
import 'package:museum/src/services/BookService.dart';

class BookBloc {
  final Databaser _databaser = Databaser();
  late final BookService _service;
  // final _book = Book();

  Sink<Book> get addition => _additionController.sink;

  final _additionController = StreamController<Book>();

  // Stream<List<Book>> items;

  BookBloc() {
    _service = BookService(_databaser);
  }
}

final bloc = BookBloc();
