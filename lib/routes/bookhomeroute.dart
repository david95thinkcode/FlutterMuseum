import 'package:flutter/material.dart';

class BookHomeRoute extends StatefulWidget {
  const BookHomeRoute({Key? key}) : super(key: key);

  @override
  State<BookHomeRoute> createState() => _BookHomeRouteState();
}

class _BookHomeRouteState extends State<BookHomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Books home"),
      ),
      body: Center(
        child: Column(
          children: const <Widget>[
            Text("Books home")
          ],
        ),
      ),
    );
  }
}

