import 'package:flutter/material.dart';
import 'package:museum/routes/createmuseumroute.dart';
import 'package:museum/routes/createvisitroute.dart';

class MuseumHomeRoute extends StatelessWidget {
  const MuseumHomeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onNewVisitPressed() {
        Navigator.pushNamed(context, "/visits/create");
    }

    void _onNewMuseumPressed() {
      Navigator.pushNamed(context, "/museums/create");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion des Musées")
      ),
      body: Center(
       child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Column(
               children: [
                 ElevatedButton(
                     onPressed: () => {
                       _onNewMuseumPressed()
                      },
                     child: const Text("Nouveau Musée")
                 ),
                 ElevatedButton(
                     onPressed: () => {
                       _onNewVisitPressed()
                     },
                     child: const Text("Nouvelle Visite")
                 )
               ],
             ),
             Text("Musées", style: Theme.of(context).textTheme.headline4,)
           ]
       ),
      )
    );
  }
}
