import 'package:flutter/material.dart';

class LibraryHomeRoute extends StatefulWidget {
  const LibraryHomeRoute({Key? key}) : super(key: key);

  @override
  State<LibraryHomeRoute> createState() => _LibraryHomeRouteState();
}

class _LibraryHomeRouteState extends State<LibraryHomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Libraries Home"),
      ),
      body: Center(
        child: Column(
          children: const <Widget>[
            Text("Libraries Home")
          ],
        ),
      ),
    );
  }
}

