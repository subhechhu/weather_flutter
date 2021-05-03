import 'package:flutter/material.dart';
import 'package:worldclock/pages/home.dart';
import 'package:worldclock/pages/newlocation.dart';
import 'package:worldclock/pages/splash.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Splash(),
      '/home': (context) => Home(),
      '/newlocation':(context) => NewLocation()
    },
  ));
}
