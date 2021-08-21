import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_task/Network/LocationGet.dart';
import 'package:weather_task/Screens/GPSlocation.dart';
import 'package:weather_task/Screens/HourScreen.dart';
import 'package:weather_task/Screens/WeekWeatherScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? lat;
  double? long;
  Dio dio = Dio();
  var currentdata;
  @override
  void initState() {
    GetGPSlocation();
    WeekWeatherScreen();
    HourScreen();
    getLocation();
    super.initState();
  }

  void getLocation() async {
    LocationGet location = LocationGet();
    await location.getLocationData();

    setState(() {
      lat = location.latitude;
      long = location.longtitude;
      getWeatherData();
    });
  }

  Future getWeatherData() async {
    try {
      Response response = await dio.get(
          'http://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&exclude=minutely,daily&appid=$apiKey&units=metric');
      var ds = response.data;
      setState(() {
        currentdata = ds['hourly'];
      });
      print(currentdata[0]['weather'][0]['icon']);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('Onefarmer',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.028,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w700),
                ))),
        actions: [
          InkWell(
            child: Image.network(
              "http://openweathermap.org/img/wn/" +
                  currentdata[0]['weather'][0]['icon'].toString() +
                  "@2x.png",
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GetGPSlocation(),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text('hi'),
      ),
    );
  }
}
