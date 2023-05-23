// 5 day / 3 hour
class ForecastDaily {
  String? cod;
  int? message;
  int? cnt;
  List<Hourly3>? listDaily;
  City? city;

  ForecastDaily({this.cod, this.message, this.cnt, this.listDaily, this.city});

  ForecastDaily.fromJson(Map<String, dynamic> json) {
    cod = json["cod"];
    message = json["message"];
    cnt = json["cnt"];
    listDaily = json["list"] == null
        ? null
        : (json["list"] as List).map((e) => Hourly3.fromJson(e)).toList();
    city = json["city"] == null ? null : City.fromJson(json["city"]);
  }

  static List<ForecastDaily> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ForecastDaily.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["cod"] = cod;
    _data["message"] = message;
    _data["cnt"] = cnt;
    if (listDaily != null) {
      _data["list"] = listDaily?.map((e) => e.toJson()).toList();
    }
    if (city != null) {
      _data["city"] = city?.toJson();
    }
    return _data;
  }

  ForecastDaily copyWith({
    String? cod,
    int? message,
    int? cnt,
    List<Hourly3>? listDaily,
    City? city,
  }) =>
      ForecastDaily(
        cod: cod ?? this.cod,
        message: message ?? this.message,
        cnt: cnt ?? this.cnt,
        listDaily: listDaily ?? this.listDaily,
        city: city ?? this.city,
      );
}

class City {
  int? id;
  String? name;
  Coord? coord;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  City(
      {this.id,
      this.name,
      this.coord,
      this.country,
      this.population,
      this.timezone,
      this.sunrise,
      this.sunset});

  City.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    coord = json["coord"] == null ? null : Coord.fromJson(json["coord"]);
    country = json["country"];
    population = json["population"];
    timezone = json["timezone"];
    sunrise = json["sunrise"];
    sunset = json["sunset"];
  }

  static List<City> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => City.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    if (coord != null) {
      _data["coord"] = coord?.toJson();
    }
    _data["country"] = country;
    _data["population"] = population;
    _data["timezone"] = timezone;
    _data["sunrise"] = sunrise;
    _data["sunset"] = sunset;
    return _data;
  }

  City copyWith({
    int? id,
    String? name,
    Coord? coord,
    String? country,
    int? population,
    int? timezone,
    int? sunrise,
    int? sunset,
  }) =>
      City(
        id: id ?? this.id,
        name: name ?? this.name,
        coord: coord ?? this.coord,
        country: country ?? this.country,
        population: population ?? this.population,
        timezone: timezone ?? this.timezone,
        sunrise: sunrise ?? this.sunrise,
        sunset: sunset ?? this.sunset,
      );
}

class Coord {
  dynamic lat;
  dynamic lon;

  Coord({this.lat, this.lon});

  Coord.fromJson(Map<String, dynamic> json) {
    lat = json["lat"];
    lon = json["lon"];
  }

  static List<Coord> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Coord.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["lat"] = lat;
    _data["lon"] = lon;
    return _data;
  }

  Coord copyWith({
    dynamic lat,
    dynamic lon,
  }) =>
      Coord(
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
      );
}

class Hourly3 {
  int? dt;
  Main? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  int? visibility;
  dynamic pop;
  Sys? sys;
  String? dtTxt;

  Hourly3(
      {this.dt,
      this.main,
      this.weather,
      this.clouds,
      this.wind,
      this.visibility,
      this.pop,
      this.sys,
      this.dtTxt});

  Hourly3.fromJson(Map<String, dynamic> json) {
    dt = json["dt"];
    main = json["main"] == null ? null : Main.fromJson(json["main"]);
    weather = json["weather"] == null
        ? null
        : (json["weather"] as List).map((e) => Weather.fromJson(e)).toList();
    clouds = json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]);
    wind = json["wind"] == null ? null : Wind.fromJson(json["wind"]);
    visibility = json["visibility"];
    pop = json["pop"];
    sys = json["sys"] == null ? null : Sys.fromJson(json["sys"]);
    dtTxt = json["dt_txt"];
  }

  static List<Hourly3> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Hourly3.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["dt"] = dt;
    if (main != null) {
      _data["main"] = main?.toJson();
    }
    if (weather != null) {
      _data["weather"] = weather?.map((e) => e.toJson()).toList();
    }
    if (clouds != null) {
      _data["clouds"] = clouds?.toJson();
    }
    if (wind != null) {
      _data["wind"] = wind?.toJson();
    }
    _data["visibility"] = visibility;
    _data["pop"] = pop;
    if (sys != null) {
      _data["sys"] = sys?.toJson();
    }
    _data["dt_txt"] = dtTxt;
    return _data;
  }

  Hourly3 copyWith({
    int? dt,
    Main? main,
    List<Weather>? weather,
    Clouds? clouds,
    Wind? wind,
    int? visibility,
    dynamic pop,
    Sys? sys,
    String? dtTxt,
  }) =>
      Hourly3(
        dt: dt ?? this.dt,
        main: main ?? this.main,
        weather: weather ?? this.weather,
        clouds: clouds ?? this.clouds,
        wind: wind ?? this.wind,
        visibility: visibility ?? this.visibility,
        pop: pop ?? this.pop,
        sys: sys ?? this.sys,
        dtTxt: dtTxt ?? this.dtTxt,
      );
}

class Sys {
  String? pod;

  Sys({this.pod});

  Sys.fromJson(Map<String, dynamic> json) {
    pod = json["pod"];
  }

  static List<Sys> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Sys.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["pod"] = pod;
    return _data;
  }

  Sys copyWith({
    String? pod,
  }) =>
      Sys(
        pod: pod ?? this.pod,
      );
}

class Wind {
  dynamic speed;
  int? deg;
  dynamic? gust;

  Wind({this.speed, this.deg, this.gust});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json["speed"];
    deg = json["deg"];
    gust = json["gust"];
  }

  static List<Wind> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Wind.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["speed"] = speed;
    _data["deg"] = deg;
    _data["gust"] = gust;
    return _data;
  }

  Wind copyWith({
    dynamic? speed,
    int? deg,
    dynamic? gust,
  }) =>
      Wind(
        speed: speed ?? this.speed,
        deg: deg ?? this.deg,
        gust: gust ?? this.gust,
      );
}

class Clouds {
  int? all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json["all"];
  }

  static List<Clouds> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Clouds.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["all"] = all;
    return _data;
  }

  Clouds copyWith({
    int? all,
  }) =>
      Clouds(
        all: all ?? this.all,
      );
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

  static List<Weather> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Weather.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["main"] = main;
    _data["description"] = description;
    _data["icon"] = icon;
    return _data;
  }

  Weather copyWith({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) =>
      Weather(
        id: id ?? this.id,
        main: main ?? this.main,
        description: description ?? this.description,
        icon: icon ?? this.icon,
      );
}

class Main {
  dynamic? temp;
  dynamic? feelsLike;
  dynamic? tempMin;
  dynamic? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  dynamic? tempKf;

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.seaLevel,
      this.grndLevel,
      this.humidity,
      this.tempKf});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json["temp"];
    feelsLike = json["feels_like"];
    tempMin = json["temp_min"];
    tempMax = json["temp_max"];
    pressure = json["pressure"];
    seaLevel = json["sea_level"];
    grndLevel = json["grnd_level"];
    humidity = json["humidity"];
    tempKf = json["temp_kf"];
  }

  static List<Main> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Main.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["temp"] = temp;
    _data["feels_like"] = feelsLike;
    _data["temp_min"] = tempMin;
    _data["temp_max"] = tempMax;
    _data["pressure"] = pressure;
    _data["sea_level"] = seaLevel;
    _data["grnd_level"] = grndLevel;
    _data["humidity"] = humidity;
    _data["temp_kf"] = tempKf;
    return _data;
  }

  Main copyWith({
    dynamic? temp,
    dynamic? feelsLike,
    dynamic? tempMin,
    dynamic? tempMax,
    int? pressure,
    int? seaLevel,
    int? grndLevel,
    int? humidity,
    dynamic? tempKf,
  }) =>
      Main(
        temp: temp ?? this.temp,
        feelsLike: feelsLike ?? this.feelsLike,
        tempMin: tempMin ?? this.tempMin,
        tempMax: tempMax ?? this.tempMax,
        pressure: pressure ?? this.pressure,
        seaLevel: seaLevel ?? this.seaLevel,
        grndLevel: grndLevel ?? this.grndLevel,
        humidity: humidity ?? this.humidity,
        tempKf: tempKf ?? this.tempKf,
      );
}
