import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/models/Museum.dart';
import 'package:museum/src/routes/editmuseumroute.dart';
import 'package:museum/src/routes/museumdetailsroute.dart';
import 'package:museum/src/services/MuseumService.dart';

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
            title: const Text("Musées")
        ),
        body: !_isLoading
            ? ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) =>
              Card(
                elevation: 3.0,
                borderOnForeground: true,
                // shadowColor: Colors.pink,
                // color: Colors.grey,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                    title: Text(
                      _list[index].nomMus,
                      style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("${_list[index].numMus} - ${_list[index].nomMus}"),
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
            : CircularProgressIndicator(),
        floatingActionButton: FloatingActionButton(
          tooltip: "Ajouter",
          child: const Icon(Icons.add),
          onPressed: _onFabpressed,
        ),
    );
  }
}
