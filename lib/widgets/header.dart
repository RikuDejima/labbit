import 'package:flutter/material.dart';
// import 'package:fluttershare/main.dart';

header() {
  return AppBar(
      toolbarHeight: 70,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/images/appbar_icon/hamburger_menu.png",
            fit: BoxFit.cover,
            height: 32,
          ),
          Image.asset(
            "assets/images/appbar_icon/labbit_logo.png",
            fit: BoxFit.cover,
            height: 32,
          ),
          Image.asset(
            "assets/images/appbar_icon/user_icon.png",
            fit: BoxFit.cover,
            height: 32,
          ),
        ],
      ));
}
