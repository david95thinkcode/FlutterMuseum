import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Styles {

  static const EdgeInsets formfieldPadding = EdgeInsets.symmetric(horizontal: 0, vertical: 16);

  static const EdgeInsets menuItemPadding = EdgeInsets.all(15.0);

  static const double menuItemElevation = 5;

  static const double menuIconWidth = 130;

  static const Color menuMuseumItemPrimaryColor = Colors.yellow;
  static const Color menuVisitItemPrimaryColor = Colors.orange;
  static const Color menuLibraryItemPrimaryColor = Colors.brown;
  static const Color menuBookItemPrimaryColor = Colors.green;
  static const Color menuCountryItemPrimaryColor = Colors.deepPurpleAccent;

  static const TextStyle menuMuseumItemTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 43, fontWeight: FontWeight.bold
  );

  static const TextStyle menuTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 43, fontWeight: FontWeight.bold
  );

  static const TextStyle productRowItemName = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 0.8),
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle productRowTotal = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 0.8),
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle productRowItemPrice = TextStyle(
    color: Color(0xFF8E8E93),
    fontSize: 13,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle searchText = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 1),
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle deliveryTimeLabel = TextStyle(
    // color: Color(0xFFC2C2C2),
    color: CupertinoColors.darkBackgroundGray,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle deliveryTime = TextStyle(
    color: CupertinoColors.secondaryLabel,
  );

  static const Color productRowDivider = Color(0xFFD9D9D9);

  static const Color scaffoldBackground = Color(0xfff0f0f0);

  static const Color searchBackground = Color(0xffe0e0e0);

  static const Color searchCursorColor = Color.fromRGBO(0, 122, 255, 1);

  static const Color searchIconColor = Color.fromRGBO(128, 128, 128, 1);

}
