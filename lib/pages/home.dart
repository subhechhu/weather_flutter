import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:worldclock/services/getIcons.dart';
import 'package:worldclock/services/time_response.dart';
import 'package:worldclock/services/weather_response.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // String country, location, region, time, flag, offSetHour, offSetMinute, sign;
  String bgImage;
  bool isDay;
  Color textColor;

  WeatherResponse weatherResponse;
  TimeResponse timeResponse;

  Map splashData = {};

  @override
  Widget build(BuildContext context) {
    if (splashData.isEmpty) {
      splashData = ModalRoute.of(context).settings.arguments;
      print(splashData);
      weatherResponse = splashData['weather_response'];
      timeResponse = splashData['time_response'];
      isDay = weatherResponse.isDay == 1;
    }
    bgImage = isDay ? 'day.png' : 'night.png';
    textColor = isDay ? Colors.grey[700] : Colors.grey[500];

    return Scaffold(
        body: Container(
      padding: EdgeInsets.fromLTRB(0, 56, 0, 50),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/$bgImage'), fit: BoxFit.fill)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox.fromSize(
            size: Size(50, 50),
            child: ClipOval(
              child: Material(
                color: Colors.blueGrey.withOpacity(0.5), // button color
                child: InkWell(
                  splashColor: Colors.grey[600], // splash color
                  onTap: () {
                    updateTime(timeResponse.sign, timeResponse.offSetHour,
                        timeResponse.offSetMinute);
                  }, // button pressed
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    timeResponse.location,
                    style: TextStyle(
                        fontSize: 20, color: textColor, letterSpacing: 2),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Image.network(
                      'https://flagcdn.com/32x24/${timeResponse.flag}.png'),
                ],
              ),
              Row(
                children: [
                  Text(
                    timeResponse.country,
                    style: TextStyle(
                        fontSize: 20, color: textColor, letterSpacing: 2),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    timeResponse.region,
                    style: TextStyle(
                        fontSize: 20, color: textColor, letterSpacing: 2),
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      dynamic result =
                      await Navigator.pushNamed(context, '/newlocation');
                      print("in main");
                      setState(() {
                        weatherResponse = result['weather_response'];
                        timeResponse = result['timeResponse'];
                        isDay = weatherResponse.isDay == 1;
                      });
                    },
                    icon: Icon(
                      Icons.edit_location_rounded,
                      color: textColor,
                      size: 20,
                    ),
                    label: Text("     "),
                  ),
                ],
              ),
              SizedBox(height: 50,),
              Text(
                timeResponse.time,
                style: TextStyle(
                    fontSize: 80,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
            ],
          ),),
          Padding(padding: EdgeInsets.all(0),
          child: Column(
            children: [
              getWeather(GetIcon.getWeatherIcon(weatherResponse.code), "Weather",
                  weatherResponse.text),
              BottomAppBar(
                color: Colors.transparent,
                elevation: 0,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      getBottomView(Icons.device_thermostat, "Temperature",
                          weatherResponse.tempC.toString() + ' °C'),
                      SizedBox(width: 10),
                      getBottomView(Icons.waves_sharp, "Wind",
                          weatherResponse.windKph.toString() + ' km/h'),
                      SizedBox(
                        width: 10,
                      ),
                      getBottomView(Icons.beach_access, "Rain",
                          weatherResponse.precipMm.toString() + " mm"),
                      SizedBox(
                        width: 10,
                      ),
                      getBottomView(Icons.whatshot, "Humidity",
                          weatherResponse.humidity.toString() + "%"),
                      SizedBox(
                        width: 10,
                      ),
                      getBottomView(Icons.cloud, "Cloud",
                          weatherResponse.cloud.toString() + "%")
                    ],
                  ),
                ),
              )
            ],
          ),)
        ],
      ),
    ));
  }

  Column getWeather(icon, type, val) {
    return Column(
      children: [
        SizedBox.fromSize(
          size: Size(70, 70),
          child: Material(
            color: Colors.blueGrey.withOpacity(0.0),
            child: InkWell(
              splashColor: Colors.grey[600],
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(weatherResponse.code == 0
                      ? "Could not generate weather for ${timeResponse.location}}"
                      : "$type in ${timeResponse.location} : $val"),
                  duration: Duration(seconds: 5),
                ));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(image: AssetImage(icon)),
                  // icon
                  // text
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          val,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  SizedBox getBottomView(icon, type, val) {
    return SizedBox.fromSize(
      size: Size(70, 70), // button width and height
      child: ClipOval(
        child: Material(
            color: Colors.blueGrey.withOpacity(0.5), // button color
            child: InkWell(
                splashColor: Colors.grey[600], // splash color
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(weatherResponse.code == 0
                        ? "$type error ${timeResponse.location}"
                        : "$type in ${timeResponse.location} at ${timeResponse.time}: $val"),
                    duration: Duration(seconds: 5),
                  ));
                }, // button pressed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.white,
                    ),
                    // icon
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      val,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    // text
                  ],
                ))),
      ),
    );
  }

  void updateTime(sign, offsethour, offsetminute) {
    DateTime currentUtc = DateTime.now().toUtc();
    DateTime current;
    if (sign == "+")
      current = currentUtc.add(Duration(
          hours: int.parse(offsethour), minutes: int.parse(offsetminute)));
    else
      current = currentUtc.subtract(Duration(
          hours: int.parse(offsethour), minutes: int.parse(offsetminute)));
    setState(() {
      timeResponse.time = DateFormat.jm().format(current);
    });
  }
}
