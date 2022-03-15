import 'package:flutter/material.dart';

class CountryHomeRoute extends StatelessWidget {
  const CountryHomeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Countries home"),
      ),
      body: Center(
        child: Column(
          children: const <Widget>[
            Text("Countries home")
          ],
        ),
      ),
    );
  }
}
