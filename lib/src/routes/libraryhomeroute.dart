import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/models/Library.dart';
import 'package:museum/src/services/LibraryService.dart';

class LibraryHomeRoute extends StatefulWidget {
  const LibraryHomeRoute({Key? key}) : super(key: key);

  @override
  State<LibraryHomeRoute> createState() => _LibraryHomeRouteState();
}

class _LibraryHomeRouteState extends State<LibraryHomeRoute> {

  late Databaser _databaser;
  late LibraryService _libService;
  late List<Library> _list;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _list = [];
    _databaser = Databaser();
    _libService = LibraryService(_databaser);
    _refresh();
  }

  void _refresh() async {
    _isLoading = true;
    final data = await _libService.all();
    setState(() {
      _list = data;
    });
    _isLoading = false;
  }

  _deleteItem(Library v) async {
    bool done = await _libService.delete(v.id!);

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

  void _onFabpressed() {
    Navigator.pushNamed(context, "/libraries/create").then((value) {
      _refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Bibliothèque")
      ),
      body: !_isLoading
          ? ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) =>
            Card(
              color: Colors.orange[50],
              margin: const EdgeInsets.all(15),
              child: ListTile(
                title: Text("#${_list[index].numMus} - ${_list[index].isbn}"),
                subtitle: Text("${_list[index].isbn} - acheté le ${_list[index].dateAchat}"),
                trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => {
                      _deleteItem(_list[index]),
                    }
                ),
              ),
            ),
      )
          : CircularProgressIndicator(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Nouvel achat",
        child: const Icon(Icons.add),
        onPressed: _onFabpressed,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked
    );
  }
}

