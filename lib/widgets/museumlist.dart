import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:museum/config/databaser.dart';
import 'package:museum/models/Museum.dart';
import 'package:museum/routes/editmuseumroute.dart';
import 'package:museum/services/MuseumService.dart';

class MuseumList extends StatefulWidget {
  const MuseumList({Key? key}) : super(key: key);

  @override
  State<MuseumList> createState() => _MuseumListState();
}

class _MuseumListState extends State<MuseumList> {
  late Databaser _databaser;
  late MuseumService _museumService;
  late List<Museum> _list;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _list = [];
    _databaser = Databaser();
    _museumService = MuseumService(_databaser);
    _refresh();
  }

  void _refresh() async {
    _isLoading = true;
    final data = await _museumService.all();
    setState(() {
      _list = data;
    });
    _isLoading = false;
  }

  _deleteItem(int id) async {
    //
    bool done = await _museumService.delete(id);

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

  _editItem(Museum museum) {
    print(museum);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditMuseumRoute(museum: museum),
      ),
    );
  }

  _showForm(int id) {

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
                  title: Text(_list[index].nomMus),
                  subtitle: Text("${_list[index].numMus} - ${_list[index].nomMus}"),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => {
                            _editItem(_list[index])
                          }
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => {
                            _deleteItem(_list[index].numMus!),
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
