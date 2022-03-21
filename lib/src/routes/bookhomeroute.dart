import 'package:flutter/material.dart';
import 'package:museum/src/ui/booklist.dart';

class BookHomeRoute extends StatefulWidget {
  const BookHomeRoute({Key? key}) : super(key: key);

  @override
  State<BookHomeRoute> createState() => _BookHomeRouteState();
}

class _BookHomeRouteState extends State<BookHomeRoute> {

  void _onFabpressed() {
    Navigator.pushNamed(context, "/books/create");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Ouvrages")
      ),
      body: const BookList(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Ajouter",
        child: const Icon(Icons.add),
        onPressed: _onFabpressed,
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked
    );
  }
}

