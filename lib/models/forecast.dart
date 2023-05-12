class Forecast {
  double? lat;
  double? lon;
  String? timezone;
  int? timezoneOffset;
  Current? current;
  List<Hourly>? hourly;
  List<Daily>? daily;

  Forecast(
      {this.lat,
      this.lon,
      this.timezone,
      this.timezoneOffset,
      this.current,
      this.hourly,
      this.daily});

  Forecast.fromJson(Map<String, dynamic> json) {
    lat = json["lat"];
    lon = json["lon"];
    timezone = json["timezone"];
    timezoneOffset = json["timezone_offset"];
    current =
        json["current"] == null ? null : Current.fromJson(json["current"]);
    hourly = json["hourly"] == null
        ? null
        : (json["hourly"] as List).map((e) => Hourly.fromJson(e)).toList();
    daily = json["daily"] == null
        ? null
        : (json["daily"] as List).map((e) => Daily.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["lat"] = lat;
    _data["lon"] = lon;
    _data["timezone"] = timezone;
    _data["timezone_offset"] = timezoneOffset;
    if (current != null) {
      _data["current"] = current?.toJson();
    }
    if (hourly != null) {
      _data["hourly"] = hourly?.map((e) => e.toJson()).toList();
    }
    if (daily != null) {
      _data["daily"] = daily?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Daily {
  int? dt;
  int? sunrise;
  int? sunset;
  int? moonrise;
  int? moonset;
  double? moonPhase;
  Temp? temp;
  FeelsLike? feelsLike;
  int? pressure;
  int? humidity;
  double? dewPoint;
  double? windSpeed;
  int? windDeg;
  dynamic windGust;
  List<Weather2>? weather;
  int? clouds;
  dynamic pop;
  dynamic uvi;

  Daily(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.moonrise,
      this.moonset,
      this.moonPhase,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.windSpeed,
      this.windDeg,
      this.windGust,
      this.weather,
      this.clouds,
      this.pop,
      this.uvi});

  Daily.fromJson(Map<String, dynamic> json) {
    dt = json["dt"];
    sunrise = json["sunrise"];
    sunset = json["sunset"];
    moonrise = json["moonrise"];
    moonset = json["moonset"];
    moonPhase = json["moon_phase"];
    temp = json["temp"] == null ? null : Temp.fromJson(json["temp"]);
    feelsLike = json["feels_like"] == null
        ? null
        : FeelsLike.fromJson(json["feels_like"]);
    pressure = json["pressure"];
    humidity = json["humidity"];
    dewPoint = json["dew_point"];
    windSpeed = json["wind_speed"];
    windDeg = json["wind_deg"];
    windGust = json["wind_gust"];
    weather = json["weather"] == null
        ? null
        : (json["weather"] as List).map((e) => Weather2.fromJson(e)).toList();
    clouds = json["clouds"];
    pop = json["pop"];
    uvi = json["uvi"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["dt"] = dt;
    _data["sunrise"] = sunrise;
    _data["sunset"] = sunset;
    _data["moonrise"] = moonrise;
    _data["moonset"] = moonset;
    _data["moon_phase"] = moonPhase;
    if (temp != null) {
      _data["temp"] = temp?.toJson();
    }
    if (feelsLike != null) {
      _data["feels_like"] = feelsLike?.toJson();
    }
    _data["pressure"] = pressure;
    _data["humidity"] = humidity;
    _data["dew_point"] = dewPoint;
    _data["wind_speed"] = windSpeed;
    _data["wind_deg"] = windDeg;
    _data["wind_gust"] = windGust;
    if (weather != null) {
      _data["weather"] = weather?.map((e) => e.toJson()).toList();
    }
    _data["clouds"] = clouds;
    _data["pop"] = pop;
    _data["uvi"] = uvi;
    return _data;
  }
}

class Weather2 {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather2({this.id, this.main, this.description, this.icon});

  Weather2.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    main = json["main"];
    description = json["description"];
    icon = json["icon"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["main"] = main;
    _data["description"] = description;
    _data["icon"] = icon;
    return _data;
  }
}

class FeelsLike {
  double? day;
  double? night;
  double? eve;
  double? morn;

  FeelsLike({this.day, this.night, this.eve, this.morn});

  FeelsLike.fromJson(Map<String, dynamic> json) {
    day = json["day"];
    night = json["night"];
    eve = json["eve"];
    morn = json["morn"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["day"] = day;
    _data["night"] = night;
    _data["eve"] = eve;
    _data["morn"] = morn;
    return _data;
  }
}

class Temp {
  double? day;
  double? min;
  double? max;
  double? night;
  double? eve;
  double? morn;

  Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});

  Temp.fromJson(Map<String, dynamic> json) {
    day = json["day"];
    min = json["min"];
    max = json["max"];
    night = json["night"];
    eve = json["eve"];
    morn = json["morn"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["day"] = day;
    _data["min"] = min;
    _data["max"] = max;
    _data["night"] = night;
    _data["eve"] = eve;
    _data["morn"] = morn;
    return _data;
  }
}

class Hourly {
  int? dt;
  dynamic temp;
  dynamic feelsLike;
  int? pressure;
  int? humidity;
  double? dewPoint;
  dynamic uvi;
  int? clouds;
  int? visibility;
  double? windSpeed;
  int? windDeg;
  dynamic windGust;
  List<Weather1>? weather;
  dynamic pop;

  Hourly(
      {this.dt,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.uvi,
      this.clouds,
      this.visibility,
      this.windSpeed,
      this.windDeg,
      this.windGust,
      this.weather,
      this.pop});

  Hourly.fromJson(Map<String, dynamic> json) {
    dt = json["dt"];
    temp = json["temp"];
    feelsLike = json["feels_like"];
    pressure = json["pressure"];
    humidity = json["humidity"];
    dewPoint = json["dew_point"];
    uvi = json["uvi"];
    clouds = json["clouds"];
    visibility = json["visibility"];
    windSpeed = json["wind_speed"];
    windDeg = json["wind_deg"];
    windGust = json["wind_gust"];
    weather = json["weather"] == null
        ? null
        : (json["weather"] as List).map((e) => Weather1.fromJson(e)).toList();
    pop = json["pop"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["dt"] = dt;
    _data["temp"] = temp;
    _data["feels_like"] = feelsLike;
    _data["pressure"] = pressure;
    _data["humidity"] = humidity;
    _data["dew_point"] = dewPoint;
    _data["uvi"] = uvi;
    _data["clouds"] = clouds;
    _data["visibility"] = visibility;
    _data["wind_speed"] = windSpeed;
    _data["wind_deg"] = windDeg;
    _data["wind_gust"] = windGust;
    if (weather != null) {
      _data["weather"] = weather?.map((e) => e.toJson()).toList();
    }
    _data["pop"] = pop;
    return _data;
  }
}

class Weather1 {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather1({this.id, this.main, this.description, this.icon});

  Weather1.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    main = json["main"];
    description = json["description"];
    icon = json["icon"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["main"] = main;
    _data["description"] = description;
    _data["icon"] = icon;
    return _data;
  }
}

class Current {
  int? dt;
  int? sunrise;
  int? sunset;
  dynamic temp;
  dynamic feelsLike;
  int? pressure;
  int? humidity;
  double? dewPoint;
  dynamic uvi;
  int? clouds;
  int? visibility;
  double? windSpeed;
  int? windDeg;
  dynamic windGust;
  List<Weather>? weather;

  Current(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.uvi,
      this.clouds,
      this.visibility,
      this.windSpeed,
      this.windDeg,
      this.windGust,
      this.weather});

  Current.fromJson(Map<String, dynamic> json) {
    dt = json["dt"];
    sunrise = json["sunrise"];
    sunset = json["sunset"];
    temp = json["temp"];
    feelsLike = json["feels_like"];
    pressure = json["pressure"];
    humidity = json["humidity"];
    dewPoint = json["dew_point"];
    uvi = json["uvi"];
    clouds = json["clouds"];
    visibility = json["visibility"];
    windSpeed = json["wind_speed"];
    windDeg = json["wind_deg"];
    windGust = json["wind_gust"];
    weather = json["weather"] == null
        ? null
        : (json["weather"] as List).map((e) => Weather.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["dt"] = dt;
    _data["sunrise"] = sunrise;
    _data["sunset"] = sunset;
    _data["temp"] = temp;
    _data["feels_like"] = feelsLike;
    _data["pressure"] = pressure;
    _data["humidity"] = humidity;
    _data["dew_point"] = dewPoint;
    _data["uvi"] = uvi;
    _data["clouds"] = clouds;
    _data["visibility"] = visibility;
    _data["wind_speed"] = windSpeed;
    _data["wind_deg"] = windDeg;
    _data["wind_gust"] = windGust;
    if (weather != null) {
      _data["weather"] = weather?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    main = json["main"];
    description = json["description"];
    icon = json["icon"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["main"] = main;
    _data["description"] = description;
    _data["icon"] = icon;
    return _data;
  }
}
