import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
         children: [
          Text(
            "My Museum",
            style: TextStyle(color:  Colors.pink, fontSize: 35, fontWeight: FontWeight.bold),
          ),
           CircularProgressIndicator()
         ]
        ),
      )
    );
  }
}
