import 'package:flutter/material.dart';
import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/models/Museum.dart';
import 'package:museum/src/routes/museums/editmuseumroute.dart';
import 'package:museum/src/routes/museums/museumdetailsroute.dart';
import 'package:museum/src/services/MuseumService.dart';
import 'package:museum/src/utils.dart';

class MuseumHomeRoute extends StatefulWidget {
  const MuseumHomeRoute({Key? key}) : super(key: key);

  @override
  State<MuseumHomeRoute> createState() => _MuseumHomeRouteState();
}

class _MuseumHomeRouteState extends State<MuseumHomeRoute> {
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
    var deleteChoice = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Etes-vous certain de vouloir supprimer ce musée ?'),
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

  _onDeletionConfirmed(int id) async {
    bool done = await _museumService.delete(id);
    Utils.deletionSuccessToast(done, null);
    if (done) _refresh();
  }

  _editItem(Museum museum) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditMuseumRoute(museum: museum),
      ),
    ).then((value) {
      _refresh();
    });
  }

  _onItemTapped(Museum museum) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => MuseumDetailsRoute(museum: museum),
      ),
    );
  }

  void _onFabpressed() {
    Navigator.pushNamed(context, "/museums/create").then((value) {
      _refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Musées (${_list.length})"),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    _onFabpressed();
                  },
                  child: Icon(Icons.add, size: 26.0,),
                )
            )
          ],
        ),
        body: !_isLoading
            ? ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) =>
              Card(
                child: ListTile(
                    title: Text(
                      _list[index].nomMus,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                    onTap: () {
                      _onItemTapped(_list[index]);
                    },
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
                              color: Colors.red,
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
            : const CircularProgressIndicator(),
    );
  }
}
