import 'package:flutter/material.dart';
import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/models/Book.dart';
import 'package:museum/src/routes/books/bookdetailsroute.dart';
import 'package:museum/src/routes/books/editbookroute.dart';
import 'package:museum/src/services/BookService.dart';
import 'package:museum/src/styles.dart';
import 'package:museum/src/utils.dart';

class BookHomeRoute extends StatefulWidget {
  const BookHomeRoute({Key? key}) : super(key: key);

  @override
  State<BookHomeRoute> createState() => _BookHomeRouteState();
}

class _BookHomeRouteState extends State<BookHomeRoute> {
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

  void _onFabpressed() {
    Navigator.pushNamed(context, "/books/create").then((value) {
      _refresh();
    });
  }

  _deleteItem(String id) async {
    var deleteChoice = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Etes-vous certain de vouloir supprimer cet ouvrage ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirmer'),
          ),
        ],
      ),
    );
    if (deleteChoice is bool) {
      if (deleteChoice == true) _onDeletionConfirmed(id);
    }
  }

  _onDeletionConfirmed(String id) async {
    bool done = await _bookService.delete(id);
    Utils.deletionSuccessToast(done, null);
    if (done) _refresh();
  }

  _editItem(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBookRoute(book: book),
      ),
    ).then((value) {
      _refresh();
    });
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Ouvrages(${_list.length})"),
        backgroundColor: Styles.menuBookItemPrimaryColor,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: _onFabpressed,
                child: Icon(
                  Icons.add,
                  size: 26.0,
                ),
              ))
        ],
      ),
      body: !_isLoading
          ? ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, index) => Card(
                // color: Colors.orange[50],
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                child: ListTile(
                    title: Text(_list[index].title),
                    onTap: () {
                      _onItemTaped(_list[index]);
                    },
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => {_editItem(_list[index])}),
                          IconButton(
                            color: Colors.red,
                              icon: const Icon(Icons.delete),
                              onPressed: () => {
                                    _deleteItem(_list[index].isbn),
                                  }),
                        ],
                      ),
                    )),
              ),
            )
          : const CircularProgressIndicator(),
    );
  }
}
