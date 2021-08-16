import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_task/Network/LocationGet.dart';
import 'package:weather_task/weatherdata/WeatherData.dart';

import 'Network/NetworkHelper.dart';

//Weather Apikey
const apiKey = "99d92cc95a2292104c6595069ad89ce4";

class GetGPSlocation extends StatefulWidget {
  const GetGPSlocation({Key? key}) : super(key: key);

  @override
  _GetGPSlocationState createState() => _GetGPSlocationState();
}

class _GetGPSlocationState extends State<GetGPSlocation> {
  Position? position;
  Position? loc;
  double? lat;
  double? long;
  double? tem;
  int? id;
  var iconn;
  String? name;
  String? main;
  var weatherdata;
  String? urls;
  WeatherData weatherData = WeatherData();

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
    });
    getWeatherData();
  }

  //Get Weather
  Future getWeatherData() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=met');
    weatherdata = await networkHelper.getData();
    setState(() {
      tem = weatherdata['main']['temp'];
      id = weatherdata['weather'][0]['id'];
      name = weatherdata['name'];
      main = weatherdata['weather'][0]['main'];
      urls = weatherData.getWeathericon(id!);

      // iconn = weatherdata['weatherdata'][0]['icon'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          children: [
            Text(
              "Temputature is :",
              style: TextStyle(color: Colors.blue, fontSize: 20.0),
            ),
            Text(
              "$tem",
              style: TextStyle(color: Colors.red),
            ),
            Divider(
              height: 10.0,
            ),
            Text(
              "ID is :",
              style: TextStyle(color: Colors.blue, fontSize: 20.0),
            ),
            Text(
              "$id",
              style: TextStyle(color: Colors.red),
            ),
            Divider(
              height: 10.0,
            ),
            Text(
              "Location is :",
              style: TextStyle(color: Colors.blue, fontSize: 20.0),
            ),
            Text(
              "$name",
              style: TextStyle(color: Colors.red),
            ),
            Divider(
              height: 10.0,
            ),
            Text(
              "Sky is :",
              style: TextStyle(color: Colors.blue, fontSize: 20.0),
            ),
            Text(
              "$main",
              style: TextStyle(color: Colors.red),
            ),
            Image(image: NetworkImage(urls!))
          ],
        ),
      ),
    ));
  }
}
