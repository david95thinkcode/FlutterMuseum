import 'package:flutter/material.dart';

class CreateVisitRoute extends StatelessWidget {
  const CreateVisitRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create visit"),
        ),
        body: Center(
          child: Column(
            children: const <Widget>[
              Text("Create visit")
            ],
          ),
        ),
    );
  }
}
