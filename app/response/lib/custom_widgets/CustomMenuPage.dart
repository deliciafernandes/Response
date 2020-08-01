import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CustomZoomScaffold.dart';

class CustomMenuPage extends StatelessWidget {
  final List<MenuItem> options = [
    MenuItem(Icons.home, 'Home'),
    MenuItem(Icons.shopping_basket, 'Subscribe for Alerts'),
    MenuItem(Icons.short_text, 'About this App'),
    MenuItem(Icons.code, 'Tell a friend'),
    MenuItem(Icons.format_list_bulleted, 'Help'),
    MenuItem(Icons.favorite, 'Feedback'),
    MenuItem(Icons.phone, 'Contact Us'),
    MenuItem(Icons.import_contacts, 'Terms & Conditions'),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        //on swiping left
        if (details.delta.dx < -6) {
          Provider.of<MenuController>(context, listen: true).toggle();
        }
      },
      child: Container(
        padding: EdgeInsets.only(
            top: 62,
            left: 32,
            bottom: 8,
            right: MediaQuery.of(context).size.width / 2.9),
        color: Color(0xff454dff),
        child: Column(
          children: <Widget>[
            Column(
              children: options.map((item) {
                return ListTile(
                  leading: Icon(
                    item.icon,
                    color: Colors.white,
                    size: 20,
                  ),
                  title: Text(
                    item.title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  String title;
  IconData icon;

  MenuItem(this.icon, this.title);
}
