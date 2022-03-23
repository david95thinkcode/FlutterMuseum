import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class Utils {

  static deletionSuccessToast(bool isDeleted, String? customMessage) {
    Fluttertoast.showToast(
    msg: isDeleted ? "Supprimé" : "Echec de suppression. Réessayez",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: isDeleted ? Colors.greenAccent : Colors.redAccent,
    textColor: isDeleted ? Colors.black : Colors.white,
    fontSize: 16.0
    );
  }
}

