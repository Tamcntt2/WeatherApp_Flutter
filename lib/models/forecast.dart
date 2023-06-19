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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["lat"] = lat;
    data["lon"] = lon;
    data["timezone"] = timezone;
    data["timezone_offset"] = timezoneOffset;
    if (current != null) {
      data["current"] = current?.toJson();
    }
    if (hourly != null) {
      data["hourly"] = hourly?.map((e) => e.toJson()).toList();
    }
    if (daily != null) {
      data["daily"] = daily?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Daily {
  int? dt;
  int? sunrise;
  int? sunset;
  int? moonrise;
  int? moonset;
  dynamic moonPhase;
  Temp? temp;
  FeelsLike? feelsLike;
  int? pressure;
  int? humidity;
  dynamic dewPoint;
  dynamic windSpeed;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["dt"] = dt;
    data["sunrise"] = sunrise;
    data["sunset"] = sunset;
    data["moonrise"] = moonrise;
    data["moonset"] = moonset;
    data["moon_phase"] = moonPhase;
    if (temp != null) {
      data["temp"] = temp?.toJson();
    }
    if (feelsLike != null) {
      data["feels_like"] = feelsLike?.toJson();
    }
    data["pressure"] = pressure;
    data["humidity"] = humidity;
    data["dew_point"] = dewPoint;
    data["wind_speed"] = windSpeed;
    data["wind_deg"] = windDeg;
    data["wind_gust"] = windGust;
    if (weather != null) {
      data["weather"] = weather?.map((e) => e.toJson()).toList();
    }
    data["clouds"] = clouds;
    data["pop"] = pop;
    data["uvi"] = uvi;
    return data;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["main"] = main;
    data["description"] = description;
    data["icon"] = icon;
    return data;
  }
}

class FeelsLike {
  dynamic day;
  dynamic night;
  dynamic eve;
  dynamic morn;

  FeelsLike({this.day, this.night, this.eve, this.morn});

  FeelsLike.fromJson(Map<String, dynamic> json) {
    day = json["day"];
    night = json["night"];
    eve = json["eve"];
    morn = json["morn"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["day"] = day;
    data["night"] = night;
    data["eve"] = eve;
    data["morn"] = morn;
    return data;
  }
}

class Temp {
  dynamic day;
  dynamic min;
  dynamic max;
  dynamic night;
  dynamic eve;
  dynamic morn;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["day"] = day;
    data["min"] = min;
    data["max"] = max;
    data["night"] = night;
    data["eve"] = eve;
    data["morn"] = morn;
    return data;
  }
}

class Hourly {
  int? dt;
  dynamic temp;
  dynamic feelsLike;
  int? pressure;
  int? humidity;
  dynamic dewPoint;
  dynamic uvi;
  int? clouds;
  int? visibility;
  dynamic windSpeed;
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
    temp = json["temp"] is int
        ? (json['temp'] as int).toDouble()
        : json['temp'] as double?;
    feelsLike = json["feels_like"];
    pressure = json["pressure"];
    humidity = json["humidity"];
    dewPoint = json["dew_point"];
    uvi = json["uvi"];
    clouds = json["clouds"];
    visibility = json["visibility"]  ;
    windSpeed = json["wind_speed"];
    windDeg = json["wind_deg"];
    windGust = json["wind_gust"];
    weather = json["weather"] == null
        ? null
        : (json["weather"] as List).map((e) => Weather1.fromJson(e)).toList();
    pop = json["pop"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["dt"] = dt;
    data["temp"] = temp;
    data["feels_like"] = feelsLike;
    data["pressure"] = pressure;
    data["humidity"] = humidity;
    data["dew_point"] = dewPoint;
    data["uvi"] = uvi;
    data["clouds"] = clouds;
    data["visibility"] = visibility;
    data["wind_speed"] = windSpeed;
    data["wind_deg"] = windDeg;
    data["wind_gust"] = windGust;
    if (weather != null) {
      data["weather"] = weather?.map((e) => e.toJson()).toList();
    }
    data["pop"] = pop;
    return data;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["main"] = main;
    data["description"] = description;
    data["icon"] = icon;
    return data;
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
  dynamic dewPoint;
  dynamic uvi;
  int? clouds;
  int? visibility;
  dynamic windSpeed;
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
    temp = json["temp"] is int
        ? (json['temp'] as int).toDouble()
        : json['temp'] as double?;
    // temp = json["temp"];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["dt"] = dt;
    data["sunrise"] = sunrise;
    data["sunset"] = sunset;
    data["temp"] = temp;
    data["feels_like"] = feelsLike;
    data["pressure"] = pressure;
    data["humidity"] = humidity;
    data["dew_point"] = dewPoint;
    data["uvi"] = uvi;
    data["clouds"] = clouds;
    data["visibility"] = visibility;
    data["wind_speed"] = windSpeed;
    data["wind_deg"] = windDeg;
    data["wind_gust"] = windGust;
    if (weather != null) {
      data["weather"] = weather?.map((e) => e.toJson()).toList();
    }
    return data;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["main"] = main;
    data["description"] = description;
    data["icon"] = icon;
    return data;
  }
}
