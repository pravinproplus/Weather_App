import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_task/Network/LocationGet.dart';
import 'package:weather_task/Network/ViewWeb.dart';
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
  var id;
  var iconn;
  var name;
  var main;
  var weatherdata;
  String? urls;
  String? ds;

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

  //Get Weather
  Future getWeatherData() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric'
        //'https://api.openweathermap.org/data/2.5/weather?lat=11.387387387387387&lon=78.33484064724306&appid=99d92cc95a2292104c6595069ad89ce4'

        );
    weatherdata = await networkHelper.getData();
    //weatherdata == null ? CircularProgressIndicator() : print(weatherdata);
    setState(() {
      getIcon();
      // iconn = weatherdata['weatherdata'][0]['icon'];
    });
  }

  Future getIcon() async {
    WeatherData weatherData = WeatherData();
    setState(() {
      tem = weatherdata['main']['temp'];
      id = weatherdata['weather'][0]['id'];
      name = weatherdata['name'];
      main = weatherdata['weather'][0]['main'];
      urls = weatherData.getWeathericon(id);
      ds = urls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: 400.0,
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
            Divider(
              height: 20.0,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(20.0)),
              child: InkWell(
                child: Image(image: NetworkImage(ds!)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ViewWeb(
                      lats: lat,
                      longs: long,
                    );
                  }));
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
