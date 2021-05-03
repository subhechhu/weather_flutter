import 'package:flutter/material.dart';
import 'package:worldclock/services/weatherservices.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    setTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/night.png'), fit: BoxFit.fill)),
        child: Center(
          child: SpinKitDoubleBounce(
            color: Colors.blueGrey,
            size: 100.0,
          ),
        ),
      ),
    );
  }

  void setTime() async {
    DateTime currentTime = DateTime.now();
    bool isDay = currentTime.hour > 6 && currentTime.hour < 18 ? true : false;
    String currentTimeStr = DateFormat.jm().format(currentTime);

    Weather weather = Weather(location: 'Kathmandu');
    await weather.getWeather();

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'country': "Nepal",
      'region': "Asia",
      'location': 'Kathmandu',
      'flag': 'np',
      'time': currentTimeStr,
      'isDay': isDay,
      'temp_c': weather.temp_c,
      'weather_code': weather.code,
      'weather_type': weather.type,
      'wind_kph': weather.wind_kph,
      'precip_mm': weather.precip_mm,
      'humidity': weather.humidity,
      'cloud': weather.cloud
    });
  }
}
