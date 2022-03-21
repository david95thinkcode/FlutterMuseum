import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/models/Book.dart';
import 'package:museum/src/routes/books/bookdetailsroute.dart';
import 'package:museum/src/routes/books/editbookroute.dart';
import 'package:museum/src/services/BookService.dart';
import 'package:museum/src/ui/books/book_tile.dart';

class BookList extends StatefulWidget {
  const BookList({Key? key}) : super(key: key);

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  late Databaser _databaser;
  late BookService _bookService;
  late List<Book> _list;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _list = [];
    _databaser = Databaser();
    _bookService = BookService(_databaser);
    _refresh();
  }

  void _refresh() async {
    _isLoading = true;
    final data = await _bookService.all();
    setState(() {
      _list = data;
    });
    _isLoading = false;
  }

  _deleteItem(String id) async {
    //
    bool done = await _bookService.delete(id);

      Fluttertoast.showToast(
          msg: done ? "Supprimé" : "Echec de suppression. Réessayez",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: done ? Colors.greenAccent : Colors.redAccent,
          textColor: done ? Colors.black : Colors.white,
          fontSize: 16.0
      );

      if (done) {
        _refresh();
      }
  }

  _editItem(Book book) {
    print(book);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBookRoute(book: book),
      ),
    );
  }

  _onItemTaped(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsRoute(book: book),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) =>
            BookTile(book: _list[index])
            // Card(
            //   color: Colors.orange[200],
            //   margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8,),
            //   child: ListTile(
            //       title: Text(_list[index].title),
            //       // subtitle: Text("${_list[index].isbn} - ${_list[index].nomMus}"),
            //       onTap: () {
            //         _onItemTaped(_list[index]);
            //       },
            //       trailing: SizedBox(
            //         width: 100,
            //         child: Row(
            //           children: [
            //             IconButton(
            //               icon: const Icon(Icons.edit),
            //               onPressed: () => {
            //                 _editItem(_list[index])
            //               }
            //             ),
            //             IconButton(
            //               icon: const Icon(Icons.delete),
            //               onPressed: () => {
            //                 _deleteItem(_list[index].isbn),
            //               }
            //             ),
            //           ],
            //         ),
            //       )),
            // ),
        )
    : CircularProgressIndicator();
  }
}