import 'package:flutter/material.dart';

import 'GPSlocation.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      home: GpsScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class GpsScreen extends StatefulWidget {
  const GpsScreen({Key? key}) : super(key: key);

  @override
  _GpsScreenState createState() => _GpsScreenState();
}

class _GpsScreenState extends State<GpsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetGPSlocation(),
    );
  }
}
