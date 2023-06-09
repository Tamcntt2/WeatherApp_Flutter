class AirQuality {
  Coord? coord;
  List<ListAQ>? listt;

  AirQuality({this.coord, this.listt});

  AirQuality.fromJson(Map<String, dynamic> json) {
    coord = json["coord"] == null ? null : Coord.fromJson(json["coord"]);
    listt = json["list"] == null
        ? null
        : (json["list"] as List).map((e) => ListAQ.fromJson(e)).toList();
  }

  static List<AirQuality> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => AirQuality.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (coord != null) {
      data["coord"] = coord?.toJson();
    }
    if (listt != null) {
      data["list"] = listt?.map((e) => e.toJson()).toList();
    }
    return data;
  }

  AirQuality copyWith({
    Coord? coord,
    List<ListAQ>? listt,
  }) =>
      AirQuality(
        coord: coord ?? this.coord,
        listt: listt ?? this.listt,
      );
}

class ListAQ {
  Main? main;
  Components? components;
  int? dt;

  ListAQ({this.main, this.components, this.dt});

  ListAQ.fromJson(Map<String, dynamic> json) {
    main = json["main"] == null ? null : Main.fromJson(json["main"]);
    components = json["components"] == null
        ? null
        : Components.fromJson(json["components"]);
    dt = json["dt"];
  }

  static List<ListAQ> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ListAQ.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (main != null) {
      data["main"] = main?.toJson();
    }
    if (components != null) {
      data["components"] = components?.toJson();
    }
    data["dt"] = dt;
    return data;
  }

  ListAQ copyWith({
    Main? main,
    Components? components,
    int? dt,
  }) =>
      ListAQ(
        main: main ?? this.main,
        components: components ?? this.components,
        dt: dt ?? this.dt,
      );
}

class Components {
  dynamic co;
  dynamic no;
  dynamic no2;
  dynamic o3;
  dynamic so2;
  dynamic pm25;
  dynamic pm10;
  dynamic nh3;

  Components(
      {this.co,
      this.no,
      this.no2,
      this.o3,
      this.so2,
      this.pm25,
      this.pm10,
      this.nh3});

  Components.fromJson(Map<String, dynamic> json) {
    co = json["co"];
    no = json["no"];
    no2 = json["no2"];
    o3 = json["o3"];
    so2 = json["so2"];
    pm25 = json["pm2_5"];
    pm10 = json["pm10"];
    nh3 = json["nh3"];
  }

  static List<Components> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Components.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["co"] = co;
    data["no"] = no;
    data["no2"] = no2;
    data["o3"] = o3;
    data["so2"] = so2;
    data["pm2_5"] = pm25;
    data["pm10"] = pm10;
    data["nh3"] = nh3;
    return data;
  }

  Components copyWith({
    dynamic co,
    dynamic no,
    dynamic o2,
    dynamic o3,
    dynamic so2,
    dynamic pm25,
    dynamic pm10,
    dynamic nh3,
  }) =>
      Components(
        co: co ?? this.co,
        no: no ?? this.no,
        no2: no2 ?? no2,
        o3: o3 ?? this.o3,
        so2: so2 ?? this.so2,
        pm25: pm25 ?? this.pm25,
        pm10: pm10 ?? this.pm10,
        nh3: nh3 ?? this.nh3,
      );
}

class Main {
  int? aqi;

  Main({this.aqi});

  Main.fromJson(Map<String, dynamic> json) {
    aqi = json["aqi"];
  }

  static List<Main> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Main.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["aqi"] = aqi;
    return data;
  }

  Main copyWith({
    int? aqi,
  }) =>
      Main(
        aqi: aqi ?? this.aqi,
      );
}

class Coord {
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json["lon"];
    lat = json["lat"];
  }

  static List<Coord> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Coord.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["lon"] = lon;
    data["lat"] = lat;
    return data;
  }

  Coord copyWith({
    double? lon,
    double? lat,
  }) =>
      Coord(
        lon: lon ?? this.lon,
        lat: lat ?? this.lat,
      );
}
