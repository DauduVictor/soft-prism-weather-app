
///A class to hold [ForecastWeatherData] model

class ForecastWeatherData {
  ForecastWeatherData({
    this.lat,
    this.lon,
    this.timezone,
    this.timezoneOffset,
    this.hourly,
    this.daily,
  });

  /// A variable to hold weather lat
  double? lat;

  /// A variable to hold weather lon
  double? lon;

  /// A variable to hold timezone
  String? timezone;

  /// A variable to hold timezone offset
  int? timezoneOffset;

  /// A variable to hold list of hour forecast
  List<Hourly>? hourly;

  /// A variable to hold list of daily forecast
  List<Daily>? daily;

  factory ForecastWeatherData.fromJson(Map<String, dynamic> json) => ForecastWeatherData(
    lat: json["lat"].toDouble(),
    lon: json["lon"].toDouble(),
    timezone: json["timezone"],
    timezoneOffset: json["timezone_offset"],
    hourly: List<Hourly>.from(json["hourly"].map((x) => Hourly.fromJson(x))),
    daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lon": lon,
    "timezone": timezone,
    "timezone_offset": timezoneOffset,
    "hourly": List<dynamic>.from(hourly!.map((x) => x.toJson())),
    "daily": List<dynamic>.from(daily!.map((x) => x.toJson())),
  };
}

class Daily {
  Daily({
    this.temp,
  });

  /// A variable to hold the temperature of the daily forecast
  Temp? temp;

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
    temp: Temp.fromJson(json["temp"]),
  );

  Map<String, dynamic> toJson() => {
    "temp": temp!.toJson(),
  };
}

class Temp {
  Temp({
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,
  });

  /// A variable to hold the daily temp
  double? day;

  /// A variable to hold the min temp
  double? min;

  /// A variable to hold the max temp
  double? max;

  /// A variable to hold the night temp
  double? night;

  /// A variable to hold the eve temp
  double? eve;

  /// A variable to hold the morn temp
  double? morn;

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
    day: json["day"].toDouble(),
    min: json["min"].toDouble(),
    max: json["max"].toDouble(),
    night: json["night"].toDouble(),
    eve: json["eve"].toDouble(),
    morn: json["morn"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "min": min,
    "max": max,
    "night": night,
    "eve": eve,
    "morn": morn,
  };
}

class Hourly {
  Hourly({
    this.temp,
  });

  /// A variable to hold the temperature of hourly forecast
  double? temp;

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
    temp: json["temp"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "temp": temp,
  };
}
