import 'package:flutter/material.dart';
import 'package:manuals/homepage.dart';

void main(){
  runApp(MaterialApp(
    home: mainpage(),
    theme: ThemeData.light().copyWith(
      primaryColor: Color(0xFF0A0E21),
      scaffoldBackgroundColor: Color(0xFF0A0E21)
    ),
  ));
}
