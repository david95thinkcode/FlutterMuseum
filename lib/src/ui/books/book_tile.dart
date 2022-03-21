import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:museum/src/models/Book.dart';
import 'package:museum/src/routes/books/bookdetailsroute.dart';
import 'package:museum/src/routes/books/editbookroute.dart';

class BookTile extends StatefulWidget {
  const BookTile({Key? key,  required this.book}) : super(key: key);
  final Book book;

  @override
  State<BookTile> createState() => _BookTileState();
}

class _BookTileState extends State<BookTile> {

  _onItemTaped() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsRoute(book: widget.book),
      ),
    );
  }

  _editItem() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBookRoute(book: widget.book),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange[50],
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8,),
      child: ListTile(
          title: Text(widget.book.title),
          // subtitle: Text("${widget.book.isbn} - ${widget.book.nomMus}"),
          onTap: () {
            _onItemTaped();
          },
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => {
                      _editItem()
                    }
                ),
                IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => {
                      // _deleteItem(widget.book.isbn),
                    }
                ),
              ],
            ),
          )),
    );
  }
}
