import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/models/Visit.dart';
import 'package:museum/src/services/VisitService.dart';

class VisitList extends StatefulWidget {
  const VisitList({Key? key}) : super(key: key);

  @override
  State<VisitList> createState() => _VisitListState();
}

class _VisitListState extends State<VisitList> {
  late Databaser _databaser;
  late VisitService _visitService;
  late List<Visit> _list;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _list = [];
    _databaser = Databaser();
    _visitService = VisitService(_databaser);
    _refresh();
  }

  void _refresh() async {
    _isLoading = true;
    final data = await _visitService.all();
    setState(() {
      _list = data;
    });
    _isLoading = false;
  }

  _deleteItem(Visit v) async {
    //
    bool done = await _visitService.delete(v);

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
              color: Colors.orange[50],
              margin: const EdgeInsets.all(15),
              child: ListTile(
                  title: Text(_list[index].firstname.toString() + " " + _list[index].lastname.toString()),
                  subtitle: Text("Date visite : ${_list[index].jour}"),
                  trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => {
                        _deleteItem(_list[index]),
                      }
                  ),
              ),
            ),
        )
    : CircularProgressIndicator();
  }
}