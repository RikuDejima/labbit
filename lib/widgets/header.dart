import 'package:flutter/material.dart';
// import 'package:fluttershare/main.dart';

header() {
  return AppBar(
    toolbarHeight: 50,
    leading: IconButton(
      icon: Icon(
        Icons.menu,
        color: Color(0XFFFF962C),
        size: 35.0,
      ),
      alignment: Alignment.topLeft,
      onPressed: () {
        // Pressed Action
      },
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.account_circle,
          color: Color(0XFFFF962C),
          size: 35,
        ),
        alignment: Alignment.topRight,
        onPressed: () {
          // Pressed Action
        },
      ),
    ],
    title: Image.asset(
      "assets/images/appbar_icon/labbit_logo.png",
      fit: BoxFit.cover,
      height: 40,
    ),
    centerTitle: true,
  );
}
