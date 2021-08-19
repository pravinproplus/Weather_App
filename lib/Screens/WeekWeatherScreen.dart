import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
          'http://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=$apiKey&units=metric');
      var ds = response.data;
      setState(() {
        weatherweekdata = ds['list'];
      });
      print(weatherweekdata[0]['main']['temp']);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: weatherweekdata.length,
          itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                width: double.maxFinite,
                height: 170.0,
                child: Stack(
                  children: [
                    Positioned(
                      top: 10.0,
                      left: 200.0,
                      child: Text(
                        'Temperature:\n' +
                            weatherweekdata[index]['main']['temp'].toString(),
                        style: texts,
                      ),
                    ),
                    Positioned(
                      top: 55.0,
                      left: 200.0,
                      child: Text(
                        'Sky:\n' +
                            weatherweekdata[index]['weather'][0]['main']
                                .toString(),
                        style: texts,
                      ),
                    ),
                    Positioned(
                      top: 100.0,
                      left: 200.0,
                      child: Text(
                        "Date:\n" + weatherweekdata[index]['dt_txt'].toString(),
                        style: texts,
                      ),
                    ),
                    Positioned(
                        top: 30.0,
                        left: 30.0,
                        child: Image.network(
                            "http://openweathermap.org/img/wn/" +
                                weatherweekdata[index]['weather'][0]['icon']
                                    .toString() +
                                "@2x.png")),
                  ],
                ),
              )
          //  ListTile(
          //   title: Text(weatherweekdata[index]['main']['temp'].toString()),
          //   subtitle:
          //       Text(weatherweekdata[index]['weather'][0]['main'].toString()),
          // ),
          ),
    );
  }
}

TextStyle texts =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
TextStyle value =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow);
