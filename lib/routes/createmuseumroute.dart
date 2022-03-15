import 'package:flutter/material.dart';

class CreateMuseumRoute extends StatelessWidget {
  const CreateMuseumRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Museum"),
      ),
      body: Center(
        child: Column(
          children: const <Widget>[Text("Create Museum")],
        ),
      ),
    );
  }
}
