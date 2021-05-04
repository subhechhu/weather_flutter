import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worldclock/services/time_response.dart';
import 'package:worldclock/services/weatherservices.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:worldclock/services/weather_response.dart';

class NewLocation extends StatefulWidget {
  @override
  _NewLocationState createState() => _NewLocationState();
}

class _NewLocationState extends State<NewLocation> {
  List _items = [];
  bool isSearching = false;
  WeatherResponse weatherResponse;

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

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/countries.json');
    final data = await json.decode(response);
    setState(() {
      _items = data;
    });
  }

  void updateLocation(item) async {
    pr.show();

    String sign = item['timezones'][3];
    String offSetHour = item['timezones'].substring(4, 6);
    String offSetMinute = item['timezones'].substring(7, 9);
    String city = item['capital'];
    String country = item['name'];

    DateTime currentUtc = DateTime.now().toUtc();
    DateTime current;
    if (sign == "+")
      current = currentUtc.add(Duration(
          hours: int.parse(offSetHour), minutes: int.parse(offSetMinute)));
    else
      current = currentUtc.subtract(Duration(
          hours: int.parse(offSetHour), minutes: int.parse(offSetMinute)));

    String currentTime = DateFormat.jm().format(current);

    TimeResponse timeResponse = TimeResponse();
    timeResponse.country = country;
    timeResponse.region = item['region'];
    timeResponse.location = city;
    timeResponse.flag = item['alpha2Code'].toLowerCase();
    timeResponse.sign = sign;
    timeResponse.offSetHour = offSetHour;
    timeResponse.offSetMinute = offSetMinute;
    timeResponse.time = currentTime;

    Weather weather = Weather(location: city);
    weatherResponse = await weather.getWeather();
    pr.hide();
    print("line 110");
    print("line 111");
    if (country == item['capital']) {
      country = "";
    }

    Navigator.pop(context,
        {'weather_response': weatherResponse, 'timeResponse': timeResponse});
  }

  void styleDialog(ProgressDialog pr) {
    pr.style(message: 'Fetching information...');
  }
}
