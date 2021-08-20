import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: weatherweekdata.length,
          itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                width: 100.0,
                height: 100.0,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      width: 80.0,
                      child: Text(
                        DateFormat('EEEE').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                weatherweekdata[index]['dt'] * 1000)),
                        style: texts,
                      ),
                    ),
                    SizedBox(
                      width: 100.0,
                    ),
                    Image.network("http://openweathermap.org/img/wn/" +
                        weatherweekdata[index]['weather'][0]['icon']
                            .toString() +
                        "@2x.png"),
                    Text(
                      weatherweekdata[index]['temp']['day'].toString() + '℃',
                      style: texts,
                    ),
                  ],
                ),
              )),
    );
  }
}

TextStyle texts =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
TextStyle value =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow);
