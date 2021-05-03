import 'dart:async';

import 'package:flutter/material.dart';
import 'package:worldclock/services/getIcons.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map weatherResponse = {};
  int code;
  String sign, offsethour, offsetminute;

  @override
  Widget build(BuildContext context) {
    weatherResponse = weatherResponse.isNotEmpty
        ? weatherResponse
        : ModalRoute.of(context).settings.arguments;

    String location = weatherResponse['location'];
    code = weatherResponse['weather_code'];
    String country = weatherResponse['country'];
    String region = weatherResponse['region'];
    String type = weatherResponse['weather_type'];
    bool isDay = weatherResponse['isDay'];
    String time = weatherResponse['time'];
    String flag = weatherResponse['flag'];
    String bgImage = isDay ? 'day.png' : 'night.png';
    Color textColor = isDay ? Colors.grey[700] : Colors.grey[500];
    String temp = weatherResponse['temp_c'].toString() + ' °C';
    String wind = weatherResponse['wind_kph'].toString() + ' km/h';
    String rain = weatherResponse['precip_mm'].toString() + " mm";
    String humidity = weatherResponse['humidity'].toString() + "%";
    String cloud = weatherResponse['cloud'].toString() + "%";
    offsethour = weatherResponse['offsethour'];
    offsetminute = weatherResponse['offsetminute'];
    sign = weatherResponse['sign'];

    return Scaffold(
        body: Container(
      padding: EdgeInsets.fromLTRB(0, 56, 0, 50),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/$bgImage'), fit: BoxFit.fill)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox.fromSize(
              size: Size(50, 50), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.blueGrey.withOpacity(0.5), // button color
                  child: InkWell(
                    splashColor: Colors.grey[600], // splash color
                    onTap: () {
                      updateTime();
                    }, // button pressed
                    child: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 100, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: TextStyle(
                        fontSize: 20, color: textColor, letterSpacing: 2),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Image.network('https://flagcdn.com/32x24/$flag.png'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(
                children: [
                  Text(
                    country,
                    style: TextStyle(
                        fontSize: 20, color: textColor, letterSpacing: 2),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    region,
                    style: TextStyle(
                        fontSize: 20, color: textColor, letterSpacing: 2),
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      dynamic result =
                          await Navigator.pushNamed(context, '/newlocation');
                      print("in main");
                      print(result);
                      setState(() {
                        weatherResponse = {
                          "country": result['country'],
                          "region": result['region'],
                          "location": result['location'],
                          "flag": result['flag'],
                          "time": result['time'],
                          "isDay": result['isDay'],
                          "temp_c": result['temp_c'],
                          "weather_code": result['weather_code'],
                          "weather_type": result['weather_type'],
                          "wind_kph": result['wind_kph'],
                          "precip_mm": result['precip_mm'],
                          "humidity": result['humidity'],
                          "cloud": result['cloud'],
                          "offsethour": result['offsethour'],
                          "offsetminute": result['offsetminute'],
                          "sign": result['sign']
                        };
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
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                time,
                style: TextStyle(
                    fontSize: 80,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
            ),
            SizedBox(
              height: 250,
            ),
            getWeather(GetIcon.getWeatherIcon(code), "Weather", type),
            BottomAppBar(
              color: Colors.transparent,
              elevation: 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    getBottomView(Icons.device_thermostat, "Temperature", temp),
                    SizedBox(width: 10),
                    getBottomView(Icons.waves_sharp, "Wind", wind),
                    SizedBox(
                      width: 10,
                    ),
                    getBottomView(Icons.beach_access, "Rain", rain),
                    SizedBox(
                      width: 10,
                    ),
                    getBottomView(Icons.whatshot, "Humidity", humidity),
                    SizedBox(
                      width: 10,
                    ),
                    getBottomView(Icons.cloud, "Cloud", cloud)
                  ],
                ),
              ),
            )
          ],
        ),
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
                  content: Text(code == 0
                      ? "Could not generate weather for ${weatherResponse['location']}"
                      : "$type in ${weatherResponse['location']}:   $val"),
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
                    content: Text(code == 0
                        ? "$type error ${weatherResponse['location']}"
                        : "$type in ${weatherResponse['location']}:   $val"),
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

  void updateTime() {
    DateTime currentUtc = DateTime.now().toUtc();
    DateTime current;
    if (sign == "+")
      current = currentUtc.add(Duration(
          hours: int.parse(offsethour), minutes: int.parse(offsetminute)));
    else
      current = currentUtc.subtract(Duration(
          hours: int.parse(offsethour), minutes: int.parse(offsetminute)));

    String currentTime = DateFormat.jm().format(current);
    bool isDay = current.hour > 6 && current.hour < 18 ? true : false;

    setState(() {
      weatherResponse = {
        "country": weatherResponse['country'],
        "region": weatherResponse['region'],
        "location": weatherResponse['location'],
        "flag": weatherResponse['flag'],
        "time": currentTime,
        "isDay": isDay,
        "temp_c": weatherResponse['temp_c'],
        "weather_code": weatherResponse['weather_code'],
        "weather_type": weatherResponse['weather_type'],
        "wind_kph": weatherResponse['wind_kph'],
        "precip_mm": weatherResponse['precip_mm'],
        "humidity": weatherResponse['humidity'],
        "cloud": weatherResponse['cloud'],
        "offsethour": weatherResponse['offsethour'],
        "offsetminute": weatherResponse['offsetminute'],
        "sign": weatherResponse['sign']
      };
    });
  }
}
