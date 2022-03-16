import 'package:flutter/material.dart';
import 'package:museum/widgets/librarylist.dart';

class LibraryHomeRoute extends StatefulWidget {
  const LibraryHomeRoute({Key? key}) : super(key: key);

  @override
  State<LibraryHomeRoute> createState() => _LibraryHomeRouteState();
}

class _LibraryHomeRouteState extends State<LibraryHomeRoute> {

  void _onFabpressed() {
    Navigator.pushNamed(context, "/libraries/create");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Bibliothèque")
      ),
      body: const LibraryList(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Nouvel achat",
        child: const Icon(Icons.add),
        onPressed: _onFabpressed,
      ),
    );
  }
}

