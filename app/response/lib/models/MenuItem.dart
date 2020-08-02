import 'package:flutter/material.dart';

class MenuItem {
  String title;
  IconData icon;
  Function onPressed;

  MenuItem(this.icon, this.title, this.onPressed);
}
