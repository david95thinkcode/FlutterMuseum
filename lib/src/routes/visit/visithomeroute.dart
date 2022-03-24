import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/models/Museum.dart';
import 'package:museum/src/models/Visit.dart';
import 'package:museum/src/services/MuseumService.dart';
import 'package:museum/src/services/VisitService.dart';
import 'package:museum/src/styles.dart';
import 'package:museum/src/utils.dart';

class VisitHomeRoute extends StatefulWidget {
  const VisitHomeRoute({Key? key}) : super(key: key);
  @override
  State<VisitHomeRoute> createState() => _VisitHomeRouteState();
}

class _VisitHomeRouteState extends State<VisitHomeRoute> {
  late Databaser _databaser;
  late VisitService _visitService;
  late MuseumService _museumService;
  late List<Visit> _list;
  late List<Museum> _museums;
  List<Widget> _dialogChildren = [];
  bool _isLoading = false;
  Museum? _selectedMuseum;
  String _selectedMuseumLabel = "";

  @override
  void initState() {
    super.initState();
    _list = [];
    _databaser = Databaser();
    _visitService = VisitService(_databaser);
    _museumService = MuseumService(_databaser);
    _refresh();
  }

  void _refresh({bool forceRefresh = false}) async {
    _isLoading = true;
    if (_dialogChildren.isEmpty) await _initMuseumDialogOptions();
    var selection = _selectedMuseum;
    if (_museums.isNotEmpty) {
      _onFilterItemPicked(selection ?? _museums.first, forceRefresh: forceRefresh);
    }
    _isLoading = false;
  }

  Future<bool> _initMuseumDialogOptions() async {
    final mdata = await _museumService.all();
    setState(() {
      _museums = mdata;
      for (Museum x in _museums) {
        _dialogChildren.add(
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, x);
            },
            child: Text(x.nomMus),
          ),
        );
      }
    });
    return true;
  }

  _showAlertBox() async {
    return showDialog<Museum>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: const Text('Choisir un musée'), children: _dialogChildren);
        });
  }

  void _onFilterTaped() async {
    dynamic tapedValue = await _showAlertBox();
    if (tapedValue is Museum) {
      _onFilterItemPicked(tapedValue);
    }
  }

  void _onFilterItemPicked(Museum museum, {bool forceRefresh = false}) async {
    var s = _selectedMuseum;
    if (s == null) _selectedMuseum = museum;
    if (forceRefresh) {
      _selectedMuseum = museum;
      List<Visit> newData = await _visitService.getMuseumVisits(museum.numMus!);
      setState(() {
        _list = newData;
        _selectedMuseumLabel = museum.nomMus;
      });
    } else {
        if (s != museum) {
          _selectedMuseum = museum;
          List<Visit> newData = await _visitService.getMuseumVisits(museum.numMus!);
          setState(() {
            _list = newData;
            _selectedMuseumLabel = museum.nomMus;
          });
        }
    }
  }

  void _onFabPressed() {
    Navigator.pushNamed(context, "/visits/create").then((value) {
      _refresh(forceRefresh: true);
    });
  }

  _deleteItem(Visit v) async {
    var deleteChoice = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirmation de retrait'),
        content: Text('Etes-vous certain de supprimer la visite effectuée par ${v.firstname} ${v.lastname} au musée ${_selectedMuseum?.nomMus} ?'),
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
      if (deleteChoice == true) _onDeletionConfirmed(v);
    }
  }

  _onDeletionConfirmed(Visit v) async {
    bool done = await _visitService.delete(v);
    Utils.deletionSuccessToast(done, null);
    if (done) _refresh(forceRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text("Visites(${_list.length})", style: const TextStyle(color:Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          subtitle: Text(_selectedMuseumLabel, style: const TextStyle(color:Colors.white), textAlign: TextAlign.center),
        ),
        backgroundColor: Styles.menuVisitItemPrimaryColor,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: _onFilterTaped,
                child: const Icon(Icons.filter_list_sharp, size: 26.0),
              )),
        ],
      ),
      body: !_isLoading
          ? ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text(_list[index].firstname.toString() +
                      " " +
                      _list[index].lastname.toString()),
                  subtitle: Text("Date visite : ${_list[index].jour}"),
                  trailing: IconButton(
                    color: Colors.red,
                      icon: const Icon(Icons.delete),
                      onPressed: () => {
                            _deleteItem(_list[index]),
                          }),
                ),
              ),
            )
          : const CircularProgressIndicator(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Ajouter",
        child: const Icon(Icons.add),
        onPressed: _onFabPressed,
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked);
  }
}
