import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worldclock/services/weatherservices.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

class NewLocation extends StatefulWidget {
  @override
  _NewLocationState createState() => _NewLocationState();
}

class _NewLocationState extends State<NewLocation> {
  List _items = [];
  bool isSearching = false;

  ProgressDialog pr;

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    styleDialog(pr);
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Search Country",
                    border: InputBorder.none,
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle:
                        TextStyle(color: Colors.grey[400], fontSize: 20)),
              )
            : Text("Choose A Location"),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Column(
        children: [
          _items.length > 0
              ? Expanded(
                  child: ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          onTap: () {
                            updateLocation(_items[index]);
                          },
                          title: Text(_items[index]["name"]),
                        ),
                      );
                    },
                  ),
                )
              : Container(
                  color: Colors.red,
                )
        ],
      ),
    );
  }

  Future<List> readJson() async {
    final String response =
        await rootBundle.loadString('assets/countries.json');
    final data = await json.decode(response);
    setState(() {
      _items = data;
    });
  }

  void updateLocation(item) async {
    String country = item['name'];
    String region = item['region'];
    String city = item['capital'];
    String flag = item['alpha2Code'].toLowerCase();

    String sign = item['timezones'][3];
    String offsetHour = item['timezones'].substring(4, 6);
    String offsetMinute = item['timezones'].substring(7, 9);

    print(sign);
    print(offsetHour);
    print(offsetMinute);

    DateTime currentUtc = DateTime.now().toUtc();
    DateTime current;
    if (sign == "+")
      current = currentUtc.add(Duration(
          hours: int.parse(offsetHour), minutes: int.parse(offsetMinute)));
    else
      current = currentUtc.subtract(Duration(
          hours: int.parse(offsetHour), minutes: int.parse(offsetMinute)));

    String currentTime = DateFormat.jm().format(current);
    bool isDay = current.hour > 6 && current.hour < 18 ? true : false;

    pr.show();

    Weather weather = Weather(location: city);
    await weather.getWeather();
    pr.hide();

    if (country == item['capital']) {
      country = "";
    }

    Navigator.pop(context, {
      'country': country,
      'region': region,
      'location': item['capital'],
      'flag': flag,
      'time': currentTime,
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

  void styleDialog(ProgressDialog pr) {
    pr.style(message: 'Fetching information...');
  }
}