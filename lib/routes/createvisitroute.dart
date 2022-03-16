import 'package:flutter/material.dart';

class CreateVisitRoute extends StatefulWidget {
  const CreateVisitRoute({Key? key}) : super(key: key);

  @override
  State<CreateVisitRoute> createState() => _CreateVisitRouteState();
}

class _CreateVisitRouteState extends State<CreateVisitRoute> {
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
