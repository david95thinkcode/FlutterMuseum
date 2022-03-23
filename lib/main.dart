
import 'package:flutter/material.dart';
// Avoid errors caused by flutter upgrade.
import 'package:flutter/widgets.dart';
import 'package:museum/src/routes/bookhomeroute.dart';
import 'package:museum/src/routes/books/createbookroute.dart';
import 'package:museum/src/routes/countries/createcountryroute.dart';
import 'package:museum/src/routes/countryhomeroute.dart';
import 'package:museum/src/routes/createmuseumroute.dart';
import 'package:museum/src/routes/createvisitroute.dart';
import 'package:museum/src/routes/library/createlibraryroute.dart';
import 'package:museum/src/routes/libraryhomeroute.dart';
import 'package:museum/src/routes/museumhomeroute.dart';
import 'package:museum/src/routes/my_home_page.dart';
import 'package:museum/src/routes/visit/visithomeroute.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Museum App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: "My Museum"),
        '/museums': (context) => const MuseumHomeRoute(),
        // '/museums/details': (context) => const MuseumDetailsRoute(),
        '/museums/create': (context) => const CreateMuseumRoute(),
        '/libraries': (context) => const LibraryHomeRoute(),
        '/libraries/create': (context) => const CreateLibraryRoute(),
        '/books': (context) => const BookHomeRoute(),
        '/books/create': (context) => const CreateBookRoute(),
        '/countries': (context) => const CountryHomeRoute(),
        '/countries/create': (context) => const CreateCountryRoute(),
        '/visits': (context) => const VisitHomeRoute(),
        '/visits/create': (context) => const CreateVisitRoute(),
      },
    );
  }
}

