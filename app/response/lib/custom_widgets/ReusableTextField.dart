import 'package:flutter/material.dart';
import 'package:response/utilities/constants.dart';

class ReusableTextField extends StatefulWidget {
  final String hintText;
  final String errorText;
  final TextInputType keyboardType;
  final Function onChanged;
  final IconData icon;

  ReusableTextField(
      {this.hintText,
      this.errorText,
      this.keyboardType,
      this.onChanged,
      this.icon});

  @override
  _ReusableTextFieldState createState() => _ReusableTextFieldState();
}

class _ReusableTextFieldState extends State<ReusableTextField> {
  bool _hidden = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          style: TextStyle(color: Color.fromRGBO(38, 50, 56, .50)),
          keyboardType: widget.keyboardType,
          obscureText: widget.keyboardType == TextInputType.visiblePassword
              ? _hidden
              : false,
          decoration: InputDecoration(
            icon: Icon(widget.icon),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Color.fromRGBO(38, 50, 56, 0.30),
              fontSize: 15.0,
              fontFamily: 'WorkSans',
            ),
            errorText: widget.errorText,
            errorStyle: TextStyle(
              color: Colors.red,
              fontSize: 12.0,
              fontFamily: 'WorkSans',
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.5),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            filled: true,
            fillColor: Colors.lightBlueAccent.withOpacity(0.05),
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          ),
          onChanged: widget.onChanged,
        ),
        Visibility(
          visible: widget.keyboardType == TextInputType.visiblePassword
              ? true
              : false,
          child: Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon:
                  _hidden ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
              iconSize: 25.0,
              color: kDarkPinkRedColor,
              onPressed: () {
                setState(() {
                  _hidden = !_hidden;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
