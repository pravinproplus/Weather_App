import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_task/Network/LocationGet.dart';
import 'package:weather_task/Screens/GPSlocation.dart';

// ignore: must_be_immutable
class WeekWeatherScreen extends StatefulWidget {
  @override
  _WeekWeatherScreenState createState() => _WeekWeatherScreenState();
}

class _WeekWeatherScreenState extends State<WeekWeatherScreen> {
  Dio dio = Dio();
  double? lat;
  double? long;
  List weatherweekdata = [];
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
          'http://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&exclude=minutely&appid=$apiKey&units=metric');
      var ds = response.data;
      setState(() {
        weatherweekdata = ds['daily'];
      });
      print(weatherweekdata[0]['temp']);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: weatherweekdata.length,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFC043),
        ),
        width: 80.0,
        child: Column(
          children: [
            Image.network("http://openweathermap.org/img/wn/" +
                weatherweekdata[index]['weather'][0]['icon'].toString() +
                "@2x.png"),
            Text(
              weatherweekdata[index]['temp']['day'].toString() + '℃',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.018,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w700),
              ),
            ),
            Text(
              DateFormat('E').format(DateTime.fromMillisecondsSinceEpoch(
                  weatherweekdata[index]['dt'] * 1000)),
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.018,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
  }
}
