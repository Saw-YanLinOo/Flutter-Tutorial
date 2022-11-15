import 'package:flutter/material.dart';
import 'package:flutter_custom_components/custom_layouts/custom_football_layout.dart';
import 'package:flutter_custom_components/custom_painter/custom_painter_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          //child:CustomPinterDemo(),
          child: CustomFootballLayout(),
        ),
      ),
    );
  }
}
