class TimeResponse {
  String _country,
      _location,
      _region,
      _time,
      _flag,
      _offSetHour,
      _offSetMinute,
      _sign;

  String get country => _country;

  set country(String value) {
    _country = value;
  }

  get location => _location;

  get sign => _sign;

  set sign(value) {
    _sign = value;
  }

  get offSetMinute => _offSetMinute;

  set offSetMinute(value) {
    _offSetMinute = value;
  }

  get offSetHour => _offSetHour;

  set offSetHour(value) {
    _offSetHour = value;
  }

  get flag => _flag;

  set flag(value) {
    _flag = value;
  }

  get time => _time;

  set time(value) {
    _time = value;
  }

  get region => _region;

  set region(value) {
    _region = value;
  }

  set location(value) {
    _location = value;
  }
}
