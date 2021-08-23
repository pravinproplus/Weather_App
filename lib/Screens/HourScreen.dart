import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_task/Network/LocationGet.dart';
import 'package:weather_task/Screens/GPSlocation.dart';

class HourScreen extends StatefulWidget {
  const HourScreen({Key? key}) : super(key: key);

  @override
  _HourScreenState createState() => _HourScreenState();
}

class _HourScreenState extends State<HourScreen> {
  Dio dio = Dio();
  double? lat;
  double? long;
  List weatherhourdata = [];
  @override
  void initState() {
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
        weatherhourdata = ds['hourly'];
      });
      // print(weatherweekdata[0]['temp']);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: weatherhourdata.length,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFC043),
        ),
        width: 60.0,
        child: Column(
          children: [
            Image.network(
              "http://openweathermap.org/img/wn/" +
                  weatherhourdata[index]['weather'][0]['icon'].toString() +
                  "@2x.png",
            ),
            Text(
              weatherhourdata[index]['temp'].toString() + '℃',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.014,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w700),
              ),
            ),
            Text(
              DateFormat('jm').format(DateTime.fromMillisecondsSinceEpoch(
                  weatherhourdata[index]['dt'] * 1000)),
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.014,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
