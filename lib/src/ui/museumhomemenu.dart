import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MuseumHomeMenu extends StatelessWidget {
  const MuseumHomeMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onNewVisitPressed() {
      Navigator.pushNamed(context, "/visits/create");
    }

    void _onNewMuseumPressed() {
      Navigator.pushNamed(context, "/museums/create");
    }

    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GridView.count(
                crossAxisCount: 2,
              children: List.generate(100, (index) {
                return Center(
                  child: Text(
                    'Item $index',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                );
              }),
            ),
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
                ),
              ],
            ),
            Text("Musées", style: Theme.of(context).textTheme.headline4),
            ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Text('List 1'),
                Text('List 2'),
                Text('List 3'),
              ],
            )
          ]
      ),
    );
  }
}
