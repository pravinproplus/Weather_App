import 'package:flutter/material.dart';
import 'package:weather_task/Network/LocationGet.dart';
import 'package:weather_task/Screens/WeekWeatherScreen.dart';
import '../Network/NetworkHelper.dart';

//Weather Apikey
const apiKey = "99d92cc95a2292104c6595069ad89ce4";

class GetGPSlocation extends StatefulWidget {
  const GetGPSlocation({Key? key}) : super(key: key);

  @override
  _GetGPSlocationState createState() => _GetGPSlocationState();
}

class _GetGPSlocationState extends State<GetGPSlocation> {
  double? lat;
  double? long;
  double? tem;
  int? id;
  String? iconn;
  String? name;
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
    setState(() {
      getIcon();
    });
  }

  Future getIcon() async {
    setState(() {
      tem = weatherdata['main']['temp'];
      id = weatherdata['weather'][0]['id'];
      name = weatherdata['name'];
      main = weatherdata['weather'][0]['main'];
      iconn = weatherdata['weather'][0]['icon'];
      urls = "http://openweathermap.org/img/wn/$iconn@2x.png";
    });
  }

  Widget displayIcon() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[350], borderRadius: BorderRadius.circular(20.0)),
      child: Image(image: NetworkImage(urls!)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: Container(
            height: 400.0,
            width: 300.0,
            child: Column(
              children: [
                Text(
                  "Temputature is :",
                  style: texts,
                ),
                Text(
                  "$tem",
                  style: value,
                ),
                Divider(
                  height: 10.0,
                ),
                Text(
                  "ID is :",
                  style: texts,
                ),
                Text(
                  "$id",
                  style: value,
                ),
                Divider(
                  height: 10.0,
                ),
                Text(
                  "Location is :",
                  style: texts,
                ),
                Text(
                  "$name",
                  style: value,
                ),
                Divider(
                  height: 10.0,
                ),
                Text(
                  "Sky is :",
                  style: texts,
                ),
                Text(
                  "$main",
                  style: value,
                ),
                Divider(
                  height: 20.0,
                ),
                urls == null ? CircularProgressIndicator() : displayIcon(),
                Divider(),
                Container(
                  height: 40.0,
                  width: 100.0,
                  decoration: BoxDecoration(color: Colors.white),
                  child: TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeekWeatherScreen())),
                    child: Text(
                      "Future Data",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
