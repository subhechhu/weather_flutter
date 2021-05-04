import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart'; // for api call
import 'package:worldclock/services/weather_response.dart';

class Weather {
  String location;

  Weather({this.location});

  Future<WeatherResponse> getWeather() async {
    String url =
        'https://api.weatherapi.com/v1/current.json?key=b9697f85f5de446c93a140406212904&aqi=no&q=$location';
    print(url);
    WeatherResponse weatherResponse = new WeatherResponse();
    try {
      Response response = await get(Uri.parse(url));
      Map data = jsonDecode(response.body);
      if (data.containsKey("error")) {
        weatherResponse.tempC = 0;
        weatherResponse.isDay = 1;
        weatherResponse.windKph = 0;
        weatherResponse.precipMm = 0;
        weatherResponse.humidity = 0;
        weatherResponse.cloud = 0;
        weatherResponse.code = 0;
        weatherResponse.text = "Could Not Get Weather Information";
      } else {
        var current = data['current'];
        weatherResponse.tempC = current['temp_c'];
        weatherResponse.isDay = current['is_day'];
        weatherResponse.windKph = current['wind_kph'];
        weatherResponse.precipMm = current['precip_mm'];
        weatherResponse.humidity = current['humidity'];
        weatherResponse.cloud = current['cloud'];

        var condition = current['condition'];
        weatherResponse.code = condition['code'];
        weatherResponse.text = condition['text'];
      }
      return weatherResponse;
    } catch (e) {
      print('error WeatherServices.dart');
      print(e);
      weatherResponse.tempC = 0;
      weatherResponse.isDay = 1;
      weatherResponse.windKph = 0;
      weatherResponse.precipMm = 0;
      weatherResponse.humidity = 0;
      weatherResponse.cloud = 0;
      weatherResponse.code = 0;
      weatherResponse.text = "Could Not Get Weather Information";
      return weatherResponse;
    }
  }
}
