import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:museum/src/config/databaser.dart';
import 'package:museum/src/models/Book.dart';
import 'package:museum/src/models/Library.dart';
import 'package:museum/src/models/Museum.dart';
import 'package:museum/src/services/BookService.dart';
import 'package:museum/src/services/LibraryService.dart';
import 'package:museum/src/services/MuseumService.dart';
import 'package:museum/src/styles.dart';

class CreateLibraryRoute extends StatefulWidget {
  const CreateLibraryRoute({Key? key}) : super(key: key);

  @override
  State<CreateLibraryRoute> createState() => _CreateLibraryRouteState();
}

class _CreateLibraryRouteState extends State<CreateLibraryRoute> {
  late Databaser _databaser;
  late MuseumService _museumService;
  late LibraryService _libraryService;
  late BookService _bookService;
  final _museumController = TextEditingController();
  final _bookController = TextEditingController();
  final _timeController = TextEditingController();
  bool _isSubmitting = false;
  Museum? _selectedMuseum;
  Book? _selectedBook;
  DateTime _selectedDate = DateTime.now();
  List<Museum> _museumsList = [];
  List<Book> _booksList = [];
  List<Widget> _bookListWidget = [];
  List<Widget> _museumListWidget = [];
  bool _shouldShowMuseumPicker = false;
  bool _shouldShowBookPicker = false;
  bool _shouldShowDatePicker = false;

  @override
  void initState() {
    super.initState();
    _databaser = Databaser();
    _museumService = MuseumService(_databaser);
    _libraryService = LibraryService(_databaser);
    _bookService = BookService(_databaser);
    _fetchMuseum();
  }

  _fetchMuseum() async {
    _museumsList = await _museumService.all();
    _booksList = await _bookService.all();

    setState(() {
      _bookListWidget = [];
      _museumListWidget = [];

      for (var x in _museumsList) {
        _museumListWidget.add(Text(x.nomMus));
      }
      for (var b in _booksList) {
        _bookListWidget.add(Text(b.title));
      }
    });
  }

  _getMuseumAtIndex(int index) {
    if (_museumsList.isNotEmpty && index < _museumsList.length) {
      var selectedMuseum = _museumsList[index];
      setState(() {
        _selectedMuseum = selectedMuseum;
        _museumController.text = selectedMuseum.nomMus;
      });
    }
  }

  _getBookAtIndex(int index) {
    if (_booksList.isNotEmpty && index < _booksList.length) {
      var selectedBook = _booksList[index];
      setState(() {
        _selectedBook = selectedBook;
        _bookController.text = selectedBook.title;
      });
    }
  }

  _resetForm() {
    _museumController.text = "";
    _bookController.text = "";
    _timeController.text = "";
    _shouldShowMuseumPicker = false;
    _shouldShowBookPicker = false;
    _shouldShowDatePicker = false;
    _isSubmitting = false;
  }

  _formIsNotFilledCorrectly() {
    Fluttertoast.showToast(
        msg: "Erreur. Veuillez tout renseigner!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  _save() async {
    setState(() {
      _isSubmitting = true;
    });

    var selectedMuseum = _selectedMuseum;
    var selectedBook = _selectedBook;

    if (selectedMuseum == null || selectedBook == null) {
      _formIsNotFilledCorrectly();
    } else {
      Library lib = Library(
          numMus: selectedMuseum.numMus!,
          isbn: selectedBook.isbn,
          dateAchat: _selectedDate.toString()
      );

      try {
        await _libraryService.store(lib);
        _resetForm();
        Fluttertoast.showToast(
            msg: "Enregistr??",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 16.0);
      } catch (e) {
        print(e.toString());
        Fluttertoast.showToast(
            msg: "Echec d'enregistrement",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

    setState(() {
      _isSubmitting = false;
    });
  }

  _onDatePicked(DateTime time) {
    setState(() {
      _selectedDate = time;
      _timeController.text = DateFormat.yMMMd().format(_selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enregistrer un nouvel achat"),
        backgroundColor: Styles.menuLibraryItemPrimaryColor,
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              Container(
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: Styles.formfieldPadding,
                                      child: TextFormField(
                                        controller: _museumController,
                                        readOnly: true,
                                        onTap: () {
                                          if (_selectedMuseum == null) {
                                            _getMuseumAtIndex(0);
                                          }
                                          setState(() {
                                            _shouldShowMuseumPicker = !_shouldShowMuseumPicker;
                                            _shouldShowDatePicker = false;
                                            _shouldShowBookPicker = false;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Mus??e concern??'
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _shouldShowMuseumPicker,
                                      child: Container(
                                          height: 130,
                                          child: CupertinoPicker(
                                            children: _museumListWidget,
                                            onSelectedItemChanged: (value) {
                                              _getMuseumAtIndex(value);
                                            },
                                            itemExtent: 25,
                                            diameterRatio: 1,
                                            looping: true,
                                          )),
                                    ),
                                    Padding(
                                      padding: Styles.formfieldPadding,
                                      child: TextFormField(
                                        controller: _bookController,
                                        readOnly: true,
                                        onTap: () {
                                          if (_selectedBook == null) {
                                            _getBookAtIndex(0);
                                          }
                                          setState(() {
                                            _shouldShowBookPicker = !_shouldShowBookPicker;
                                            _shouldShowDatePicker = false;
                                            _shouldShowMuseumPicker = false;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Ouvrage achet??'
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _shouldShowBookPicker,
                                      child: Container(
                                          height: 130,
                                          child: CupertinoPicker(
                                            children: _bookListWidget,
                                            onSelectedItemChanged: (value) {
                                              _getBookAtIndex(value);
                                            },
                                            itemExtent: 25,
                                            diameterRatio: 1,
                                            useMagnifier: true,
                                            looping: true,
                                          )),
                                    ),
                                    Padding(
                                      padding: Styles.formfieldPadding,
                                      child: TextFormField(
                                        controller: _timeController,
                                        readOnly: true,
                                        onTap: () {
                                          if (_timeController.text.isEmpty) {
                                            _onDatePicked(DateTime.now());
                                          }
                                          setState(() {
                                            _shouldShowDatePicker = !_shouldShowDatePicker;
                                            _shouldShowBookPicker = false;
                                            _shouldShowMuseumPicker = false;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Touchez pour changer...',
                                            labelText: "Date d'achat"),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _shouldShowDatePicker,
                                      child: Container(
                                        height: 200,
                                        child: CupertinoDatePicker(
                                          mode: CupertinoDatePickerMode.date,
                                          initialDateTime: _selectedDate,
                                          onDateTimeChanged: (DateTime newDateTime) {
                                            _onDatePicked(newDateTime);
                                          },
                                        ),
                                      ),
                                    ),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.symmetric(vertical: 10),
                                              child: !_isSubmitting
                                                  ? ElevatedButton(
                                                child: const Text("Enregistrer l'achat"),
                                                onPressed: _save,
                                              )
                                                  : CircularProgressIndicator()),
                                        ]),
                                  ]
                              )
                          )
                      )
                    ],
                  )
              ),
            ],
          )
      ),
    );
  }
}
