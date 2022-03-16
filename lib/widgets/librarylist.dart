import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:museum/config/databaser.dart';
import 'package:museum/models/Library.dart';
import 'package:museum/models/Visit.dart';
import 'package:museum/routes/editmuseumroute.dart';
import 'package:museum/services/LibraryService.dart';

class LibraryList extends StatefulWidget {
  const LibraryList({Key? key}) : super(key: key);

  @override
  State<LibraryList> createState() => _LibraryListState();
}

class _LibraryListState extends State<LibraryList> {
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

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) =>
            Card(
              color: Colors.orange[200],
              margin: const EdgeInsets.all(15),
              child: ListTile(
                  title: Text("#${_list[index].numMus} - ${_list[index].isbn}"),
                  subtitle: Text("${_list[index].isbn} - acheté le ${_list[index].dateAchat}"),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => {
                            _deleteItem(_list[index]),
                          }
                        ),
                      ],
                    ),
                  )),
            ),
        )
    : CircularProgressIndicator();
  }
}
