import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worldclock/services/time_response.dart';
import 'package:worldclock/services/weather_response.dart';
import 'package:worldclock/services/weatherservices.dart';
import 'package:intl/intl.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/main.png'), fit: BoxFit.fill)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Open Sans Condensed'),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('W E A T H E R'),
                    ],
                    onFinished: () {
                      setTime();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setTime() async {
    Weather weather = Weather(location: 'Kathmandu');
    WeatherResponse response = await weather.getWeather();

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'weather_response': response,
      'time_response': getTimeResponse()
    });
  }

  String getTime() {
    return DateFormat.jm().format(DateTime.now());
  }

  TimeResponse getTimeResponse() {
    TimeResponse timeResponse = TimeResponse();
    timeResponse.country = "Nepal";
    timeResponse.region = "Asia";
    timeResponse.location = "Kathmandu";
    timeResponse.flag = "np";
    timeResponse.time = getTime();
    timeResponse.sign = "+";
    timeResponse.offSetHour = "5";
    timeResponse.offSetMinute = "45";
    return timeResponse;
  }
}
