import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:museum/src/styles.dart';

class CreditRoute extends StatelessWidget {
  const CreditRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Credits")),
      body: Container(
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          width: Styles.menuIconWidth,
                          image: AssetImage('assets/images/smile.png')
                      ),
                      Text(
                        "Merci d'utiliser notre app",
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "My Museum",
                        style: TextStyle(fontSize: 40, color: Colors.pink, fontWeight: FontWeight.bold),
                      ),
                      Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 1.0,
                            color: Colors.yellow[50],
                            borderOnForeground: true,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(children: const [
                                Text(
                                  "David K. Hiheaglo",
                                  style: TextStyle(fontSize: 25),
                                ),
                                Text("davidhihea@gmail.com"),
                                Text("&", style: TextStyle(fontSize: 25)),
                                Text("Regis Sinkpota", style: TextStyle(fontSize: 25))
                              ]),
                            ),
                          )
                      ),

                    ],
                  )))),
    );
  }
}
