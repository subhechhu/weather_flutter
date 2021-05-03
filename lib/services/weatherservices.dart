import 'dart:convert';

import 'package:http/http.dart'; // for api call

class Weather {
  String location;
  double temp_c = 0;
  int code = 0;
  String type = "";
  int humidity = 0;
  int cloud = 0;
  double precip_mm = 0;
  double wind_kph = 0;

  Weather({this.location});

  Future<void> getWeather() async {
    String url =
        'https://api.weatherapi.com/v1/current.json?key=b9697f85f5de446c93a140406212904&aqi=no&q=$location';
    print(url);
    try {
      Response response = await get(Uri.parse(url));
      Map data = jsonDecode(response.body);

      if (data.containsKey("error")) {
        print("inside if method");
        type = "Could Not Get Weather Information";
      } else {
        var current = data['current'];
        temp_c = current['temp_c'];

        var condition = current['condition'];
        code = condition['code'];
        type = condition['text'];
        wind_kph = current['wind_kph'];
        precip_mm = current['precip_mm'];
        humidity = current['humidity'];
        cloud = current['cloud'];
      }
    } catch (e) {
      print('error ==========================');
      print(e);
    }
  }
}
