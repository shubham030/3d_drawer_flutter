import 'dart:math' as math;

import 'package:animated_drawer_3d/animated_drawer_3d.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';
import 'main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "3d Animated Drawer",
      home: AnimatedDrawer3D(
        mainPage: MainPage(),
        secondPage: MyDrawer(),
      ),
    );
  }
}






