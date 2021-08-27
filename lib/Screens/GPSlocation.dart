import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_task/Network/LocationGet.dart';
import 'package:weather_task/Screens/HomeScreen.dart';
import 'package:weather_task/Screens/HourScreen.dart';
import 'package:weather_task/Screens/WeekWeatherScreen.dart';
import '../Network/NetworkHelper.dart';
import 'package:google_fonts/google_fonts.dart';

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
  bool isNull = true;
  String? iconn;
  String? name;
  var main;
  var date;
  var weatherdata;
  String? urls;
  String? ds;
  var windspeed;
  var humd;

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
      windspeed = weatherdata['wind']['speed'];
      main = weatherdata['weather'][0]['main'];
      iconn = weatherdata['weather'][0]['icon'];
      humd = weatherdata['main']['humidity'];
      urls = "http://openweathermap.org/img/wn/$iconn@2x.png";
      isNull = !isNull;
    });
  }

  void loadingBar(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              color: Color(0xFF00D3DB),
            ),
          );
        });
  }

  Widget displayIcon() {
    return Image(
      image: NetworkImage(urls!),
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return isNull == true
        ? Scaffold(
            // backgroundColor: Color(0xFFFFC043),
            body: Center(
              child: CircularProgressIndicator(
                color: Color(0xFF00D3DB),
              ),
            ),
          )
        : SafeArea(
            child: Scaffold(
              backgroundColor: Color(0xFFFFC043),
              body: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Column(
                  children: [
                    Container(
                      height: h / 2,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        // color: Colors.blue,
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFFEFAA1F),
                              Color(0xFFFFC043),
                            ]),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen())),
                                icon: Icon(
                                  Icons.keyboard_backspace,
                                  size: h / 22,
                                ),
                              ),
                              SizedBox(
                                width: w / 5,
                              ),
                              Text("$main",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.050,
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w700),
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //circular indicator
                              date == null
                                  ? CircularProgressIndicator()
                                  : Text(
                                      DateFormat('yMMMEd').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              date * 1000)),
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.018,
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                              Text(
                                " | ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "$name",
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.018,
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "$tem" + "℃",
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.088,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w700)),
                          ),
                          displayIcon(),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.only(top: h / 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Wind Speed : $windspeed/hr",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.018,
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.w700)),
                                  ),
                                  Text(
                                    "Humidity: $humd",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.018,
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.w700)),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: h / 6,
                      child: WeekWeatherScreen(),
                    ),
                    SizedBox(
                      height: h / 25,
                    ),
                    Text(
                      'Hour',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.018,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w700)),
                    ),
                    SizedBox(height: h / 35),
                    Container(
                      height: h / 6,
                      child: HourScreen(),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
