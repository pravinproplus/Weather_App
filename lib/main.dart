import 'package:flutter/material.dart';
import 'package:weather_task/Screens/HomeScreen.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      home: GpsScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xFFFFC043)),
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
    return SafeArea(
      child: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
