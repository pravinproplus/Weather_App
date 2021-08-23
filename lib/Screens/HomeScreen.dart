import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_task/Network/LocationGet.dart';
import 'package:weather_task/Screens/GPSlocation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? lat;
  double? long;
  String? iconn;
  bool isNull = true;
  String? urls;
  Dio dio = Dio();
  var currentdata;
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
      print(lat);
      getWeatherData();
    });
  }

  Future getWeatherData() async {
    try {
      Response response = await dio.get(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric');
      var ds = response.data;
      setState(() {
        iconn = ds['weather'][0]['icon'];
        urls = "http://openweathermap.org/img/wn/$iconn@2x.png";
        isNull = !isNull;
      });
      print(urls);
    } catch (e) {
      print(e);
    }
  }

  Widget displayIcon() {
    return Image(
      image: NetworkImage(urls!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isNull == true
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  'Onefarmer',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.028,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              actions: [
                InkWell(
                  child: urls == null
                      ? CircularProgressIndicator()
                      : displayIcon(),
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
