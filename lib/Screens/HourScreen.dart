import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_task/Network/LocationGet.dart';
import 'package:weather_task/Network/NetworkHelper.dart';
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
      gethourData();
    });
  }

  Future gethourData() async {
    NetworkHelper networkHelper = NetworkHelper(
        'http://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&exclude=minutely,daily&appid=$apiKey&units=metric');
    var ds = await networkHelper.getData();
    setState(() {
      weatherhourdata = ds['hourly'];
    });
  }

  Widget displayIcon(int index, double h) {
    return Image.network(
      "http://openweathermap.org/img/wn/" +
          weatherhourdata[index]['weather'][0]['icon'].toString() +
          "@2x.png",
      height: h / 11.5,
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: weatherhourdata.length,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFC043),
        ),
        child: Column(
          children: [
            displayIcon(index, h),
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
