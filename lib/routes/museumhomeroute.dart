import 'package:flutter/material.dart';
import 'package:museum/config/databaser.dart';
import 'package:museum/models/Museum.dart';
import 'package:museum/services/MuseumService.dart';
import 'package:museum/widgets/museumlist.dart';

class MuseumHomeRoute extends StatefulWidget {
  const MuseumHomeRoute({Key? key}) : super(key: key);

  @override
  State<MuseumHomeRoute> createState() => _MuseumHomeRouteState();
}

class _MuseumHomeRouteState extends State<MuseumHomeRoute> {

  @override
  void initState() {
    super.initState();
  }

  void _onFabpressed() {
    Navigator.pushNamed(context, "/museums/create");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            title: const Text("Musées")
        ),
        body: const MuseumList(),
        floatingActionButton: FloatingActionButton(
          tooltip: "Ajouter",
          child: const Icon(Icons.add),
          onPressed: _onFabpressed,
        ),
    );
  }
}
