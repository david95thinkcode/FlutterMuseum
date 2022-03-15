import 'package:flutter/material.dart';

class BookHomeRoute extends StatelessWidget {
  const BookHomeRoute({Key? key}) : super(key: key);

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
