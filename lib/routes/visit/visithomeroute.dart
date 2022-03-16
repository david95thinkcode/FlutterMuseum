import 'package:flutter/material.dart';
import 'package:museum/config/databaser.dart';
import 'package:museum/models/Museum.dart';
import 'package:museum/services/MuseumService.dart';
import 'package:museum/widgets/museumlist.dart';
import 'package:museum/widgets/visitlist.dart';

class VisitHomeRoute extends StatefulWidget {
  const VisitHomeRoute({Key? key}) : super(key: key);

  @override
  State<VisitHomeRoute> createState() => _VisitHomeRouteState();
}

class _VisitHomeRouteState extends State<VisitHomeRoute> {

  @override
  void initState() {
    super.initState();
  }

  void _onFabPressed() {
    Navigator.pushNamed(context, "/visits/create");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Musées")
      ),
      body: const VisitList(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Ajouter",
        child: const Icon(Icons.add),
        onPressed: _onFabPressed,
      ),
    );
  }
}
