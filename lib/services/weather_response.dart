class WeatherResponse {
  // fields for Location Object
  String _name = "", _region = "", _country = "", _tzId = "", _localtime = "";
  double _lat = 0, _lon = 0;
  int _localtimeEpoch = 0;

  //Fields for Current Object
  String _lastUpdated="", _windDir="";
  int _lastUpdatedEpoch=0, _isDay=0, _windDegree=0, _humidity=0, _cloud=0;
  double _tempC=0,
      _tempF=0,
      _windMph=0,
      _windKph=0,
      _pressureMb=0,
      _pressureIn=0,
      _precipMm=0;
  double _precipIn=0, _feelslikeC=0, _feelslikeF=0, _visKm=0, _visMiles=0, _uv=0, _gustMph=0;
  double _gustKph=0;

  //Fields for Condition Object
  String _text="", _icon="";
  int _code=0;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  get region => _region;

  set region(value) {
    _region = value;
  }

  get country => _country;

  set country(value) {
    _country = value;
  }

  get tzId => _tzId;

  set tzId(value) {
    _tzId = value;
  }

  get localtime => _localtime;

  set localtime(value) {
    _localtime = value;
  }

  double get lat => _lat;

  set lat(double value) {
    _lat = value;
  }

  get lon => _lon;

  set lon(value) {
    _lon = value;
  }

  int get localtimeEpoch => _localtimeEpoch;

  set localtimeEpoch(int value) {
    _localtimeEpoch = value;
  }

  String get lastUpdated => _lastUpdated;

  set lastUpdated(String value) {
    _lastUpdated = value;
  }

  get windDir => _windDir;

  set windDir(value) {
    _windDir = value;
  }

  int get lastUpdatedEpoch => _lastUpdatedEpoch;

  set lastUpdatedEpoch(int value) {
    _lastUpdatedEpoch = value;
  }

  get isDay => _isDay;

  set isDay(value) {
    _isDay = value;
  }

  get windDegree => _windDegree;

  set windDegree(value) {
    _windDegree = value;
  }

  get humidity => _humidity;

  set humidity(value) {
    _humidity = value;
  }

  get cloud => _cloud;

  set cloud(value) {
    _cloud = value;
  }

  double get tempC => _tempC;

  set tempC(double value) {
    _tempC = value;
  }

  get tempF => _tempF;

  set tempF(value) {
    _tempF = value;
  }

  get windMph => _windMph;

  set windMph(value) {
    _windMph = value;
  }

  get windKph => _windKph;

  set windKph(value) {
    _windKph = value;
  }

  get pressureMb => _pressureMb;

  set pressureMb(value) {
    _pressureMb = value;
  }

  get pressureIn => _pressureIn;

  set pressureIn(value) {
    _pressureIn = value;
  }

  get precipMm => _precipMm;

  set precipMm(value) {
    _precipMm = value;
  }

  double get precipIn => _precipIn;

  set precipIn(double value) {
    _precipIn = value;
  }

  get feelslikeC => _feelslikeC;

  set feelslikeC(value) {
    _feelslikeC = value;
  }

  get feelslikeF => _feelslikeF;

  set feelslikeF(value) {
    _feelslikeF = value;
  }

  get visKm => _visKm;

  set visKm(value) {
    _visKm = value;
  }

  get visMiles => _visMiles;

  set visMiles(value) {
    _visMiles = value;
  }

  get uv => _uv;

  set uv(value) {
    _uv = value;
  }

  get gustMph => _gustMph;

  set gustMph(value) {
    _gustMph = value;
  }

  double get gustKph => _gustKph;

  set gustKph(double value) {
    _gustKph = value;
  }

  String get text => _text;

  set text(String value) {
    _text = value;
  }

  get icon => _icon;

  set icon(value) {
    _icon = value;
  }

  int get code => _code;

  set code(int value) {
    _code = value;
  }

  @override
  String toString() {
    return 'Weather_response{_name: $_name, _region: $_region, _country: $_country, _tzId: $_tzId, _localtime: $_localtime, _lat: $_lat, _lon: $_lon, _localtimeEpoch: $_localtimeEpoch, _lastUpdated: $_lastUpdated, _windDir: $_windDir, _lastUpdatedEpoch: $_lastUpdatedEpoch, _isDay: $_isDay, _windDegree: $_windDegree, _humidity: $_humidity, _cloud: $_cloud, _tempC: $_tempC, _tempF: $_tempF, _windMph: $_windMph, _windKph: $_windKph, _pressureMb: $_pressureMb, _pressureIn: $_pressureIn, _precipMm: $_precipMm, _precipIn: $_precipIn, _feelslikeC: $_feelslikeC, _feelslikeF: $_feelslikeF, _visKm: $_visKm, _visMiles: $_visMiles, _uv: $_uv, _gustMph: $_gustMph, _gustKph: $_gustKph, _text: $_text, _icon: $_icon, _code: $_code}';
  }
}
