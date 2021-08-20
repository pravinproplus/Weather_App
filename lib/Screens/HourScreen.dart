import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_task/Network/LocationGet.dart';
import 'package:weather_task/Screens/GPSlocation.dart';

import 'WeekWeatherScreen.dart';

class HourScreen extends StatefulWidget {
  const HourScreen({Key? key}) : super(key: key);

  @override
  _HourScreenState createState() => _HourScreenState();
}

class _HourScreenState extends State<HourScreen> {
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
          'http://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&exclude=minutely,daily&appid=$apiKey&units=metric');
      var ds = response.data;
      setState(() {
        weatherweekdata = ds['hourly'];
      });
      print(weatherweekdata[0]['temp']);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: weatherweekdata.length,
          itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                width: 100.0,
                height: 100.0,
                child: Column(
                  children: [
                    Image.network("http://openweathermap.org/img/wn/" +
                        weatherweekdata[index]['weather'][0]['icon']
                            .toString() +
                        "@2x.png"),
                    Text(
                      weatherweekdata[index]['temp'].toString() + '℃',
                      style: texts,
                    ),
                    Text(
                      DateFormat('jm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              weatherweekdata[index]['dt'] * 1000)),
                      style: texts,
                    ),
                  ],
                ),
              )),
    );
  }
}
