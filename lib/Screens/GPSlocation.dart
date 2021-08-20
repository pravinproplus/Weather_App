import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_task/Network/LocationGet.dart';
import 'package:weather_task/Screens/HourScreen.dart';
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
  var date;
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
      date = weatherdata['dt'];
      print(date);
      main = weatherdata['weather'][0]['main'];
      iconn = weatherdata['weather'][0]['icon'];
      urls = "http://openweathermap.org/img/wn/$iconn@2x.png";
    });
  }

  Widget displayIcon() {
    return Container(
      child: Image(
        image: NetworkImage(urls!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          color: Colors.blue,
          height: double.maxFinite,
          width: double.maxFinite,
          child: Column(
            children: [
              Container(
                height: 350.0,
                width: double.maxFinite,
                decoration: BoxDecoration(color: Colors.blue),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "$main",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 70.0,
                        ),
                        Text(
                          DateFormat('yMMMEd').format(
                              DateTime.fromMillisecondsSinceEpoch(date * 1000)),
                          style: texts,
                        ),
                        Divider(
                          thickness: 2,
                          height: 10.0,
                          indent: 10,
                          color: Colors.blue,
                        ),
                        Text(
                          "$name",
                          style: texts,
                        ),
                      ],
                    ),
                    Text(
                      "$tem" + "℃",
                      style: TextStyle(color: Colors.white, fontSize: 80.0),
                    ),
                    urls == null ? CircularProgressIndicator() : displayIcon(),
                  ],
                ),
              ),
              Container(
                height: 150.0,
                child: HourScreen(),
              ),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  height: 300.0,
                  child: WeekWeatherScreen(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
