import 'package:flutter/material.dart';
import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/models/Museum.dart';
import 'package:museum/src/models/libe.dart';
import 'package:museum/src/services/LibraryService.dart';
import 'package:museum/src/services/MuseumService.dart';
import 'package:museum/src/styles.dart';
import 'package:museum/src/utils.dart';

class LibraryHomeRoute extends StatefulWidget {
  const LibraryHomeRoute({Key? key}) : super(key: key);
  @override
  State<LibraryHomeRoute> createState() => _LibraryHomeRouteState();
}

class _LibraryHomeRouteState extends State<LibraryHomeRoute> {
  late Databaser _databaser;
  late LibraryService _libService;
  late MuseumService _museumService;
  late List<Libe> _list;
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
    _libService = LibraryService(_databaser);
    _museumService = MuseumService(_databaser);
    _refresh();
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

  void _refresh({bool forceRefresh = false}) async {
    _isLoading = true;
    if (_dialogChildren.isEmpty) await _initMuseumDialogOptions();
    // Select the first item and fetch related library
    var selection = _selectedMuseum;
    if (_museums.isNotEmpty) {
      _onFilterItemPicked(selection ?? _museums.first, forceRefresh: forceRefresh);
    }
    _isLoading = false;
  }

  _deleteItem(int id) async {
    var deleteChoice = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirmation de retrait'),
        content: Text('Etes-vous certain de retirer ce livre de la bibliotheque du musée ${_selectedMuseum?.nomMus} ?'),
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

  _onDeletionConfirmed(int libraryId) async {
    bool done = await _libService.delete(libraryId);
    Utils.deletionSuccessToast(done, null);
    if (done) _refresh(forceRefresh: true);
  }

  void _onFabpressed() {
    Navigator.pushNamed(context, "/libraries/create").then((value) {
      _refresh(forceRefresh: true);
    });
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
      List<Libe> newData = await _libService.getMuseumLibrary(museum.numMus!);
      setState(() {
        _list = newData;
        _selectedMuseumLabel = museum.nomMus;
      });
    } else {
      if (s != museum) {
        _selectedMuseum = museum;
        List<Libe> newData = await _libService.getMuseumLibrary(museum.numMus!);
        setState(() {
          _list = newData;
          _selectedMuseumLabel = museum.nomMus;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ListTile(
            title: Text("Bibliothèque - ${_list.length} ${_list.isNotEmpty ? 'ouvrages' : 'ouvrage'}", style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            subtitle: Text(_selectedMuseumLabel, style: const TextStyle(color:Colors.white), textAlign: TextAlign.center),
          ),
          backgroundColor: Styles.menuLibraryItemPrimaryColor,
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
                  // color: Colors.orange[50],
                  margin: const EdgeInsets.all(15),
                  child: ListTile(
                    title: Text("${_list[index].book?.title}"),
                    subtitle: Text("Acheté le ${_list[index].date}"),
                    trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () => {
                              _deleteItem(_list[index].library!),
                            }),
                  ),
                ),
              )
            : const CircularProgressIndicator(),
        floatingActionButton: FloatingActionButton(
          tooltip: "Nouvel achat",
          child: const Icon(Icons.add),
          onPressed: _onFabpressed,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked);
  }
}
