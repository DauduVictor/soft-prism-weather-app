
///A class to hold [WeatherData] model

class WeatherData {

  WeatherData({
    this.coord,
    this.weather,
    this.main,
    this.name,
    this.cod,
  });

  /// A variable to hold coord details
  Coord? coord;

  /// A variable to hold weather detail
  List<Weather>? weather;

  /// A class to hold weather main detail
  Main? main;

  /// A variable to hold the city name
  String? name;

  /// A variable to hold the status code
  int? cod;

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
    coord: Coord.fromJson(json["coord"]),
    weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
    main: Main.fromJson(json["main"]),
    name: json["name"],
    cod: json["cod"],
  );

  Map<String, dynamic> toJson() => {
    "coord": coord!.toJson(),
    "weather": List<dynamic>.from(weather!.map((x) => x.toJson())),
    "main": main!.toJson(),
    "name": name,
    "cod": cod,
  };
}

///A class to hold coordinate details used by [WeatherData] class
class Coord {
  Coord({
    this.lon,
    this.lat,
  });

  /// A variable to hold longitude
  double? lon;

  /// A variable to hold latitude
  double? lat;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
    lon: json["lon"].toDouble(),
    lat: json["lat"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lon": lon,
    "lat": lat,
  };
}

/// A class to hold details of main used by [WeatherData] class
class Main {

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  /// A variable to hold the temperature
  double? temp;

  /// A variable to hold feels like
  double? feelsLike;

  /// A variable to hold min temp
  double? tempMin;

  /// A variable to hold max temp
  double? tempMax;

  /// A variable to hold pressure
  int? pressure;

  /// A variable to hold humidity
  int? humidity;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
    temp: json["temp"].toDouble(),
    feelsLike: json["feels_like"].toDouble(),
    tempMin: json["temp_min"].toDouble(),
    tempMax: json["temp_max"].toDouble(),
    pressure: json["pressure"],
    humidity: json["humidity"],
  );

  Map<String, dynamic> toJson() => {
    "temp": temp,
    "feels_like": feelsLike,
    "temp_min": tempMin,
    "temp_max": tempMax,
    "pressure": pressure,
    "humidity": humidity,
  };
}

class Weather {

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  /// A variable to hold weather id
  int? id;

  /// A variable to hold main
  String? main;

  /// A variable to hold description
  String? description;

  /// A variable to hold icon
  String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json["id"],
    main: json["main"],
    description: json["description"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main": main,
    "description": description,
    "icon": icon,
  };
}