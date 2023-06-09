class MyLocation2 {
  // Location from nominatim: get list location from address
  int? placeId;
  String? licence;
  String? osmType;
  int? osmId;
  List<String>? boundingbox;
  String? lat;
  String? lon;
  String? displayName;
  String? class2;
  String? type;
  double? importance;
  String? icon;

  MyLocation2(
      {this.placeId,
      this.licence,
      this.osmType,
      this.osmId,
      this.boundingbox,
      this.lat,
      this.lon,
      this.displayName,
      this.class2,
      this.type,
      this.importance,
      this.icon});

  MyLocation2.fromJson(Map<String, dynamic> json) {
    placeId = json["place_id"];
    licence = json["licence"];
    osmType = json["osm_type"];
    osmId = json["osm_id"];
    boundingbox = json["boundingbox"] == null
        ? null
        : List<String>.from(json["boundingbox"]);
    lat = json["lat"];
    lon = json["lon"];
    displayName = json["display_name"];
    class2 = json["class"];
    type = json["type"];
    importance = json["importance"];
    icon = json["icon"];
  }

  static List<MyLocation2> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => MyLocation2.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["place_id"] = placeId;
    data["licence"] = licence;
    data["osm_type"] = osmType;
    data["osm_id"] = osmId;
    if (boundingbox != null) {
      data["boundingbox"] = boundingbox;
    }
    data["lat"] = lat;
    data["lon"] = lon;
    data["display_name"] = displayName;
    data["class"] = class2;
    data["type"] = type;
    data["importance"] = importance;
    data["icon"] = icon;
    return data;
  }

  MyLocation2 copyWith({
    int? placeId,
    String? licence,
    String? osmType,
    int? osmId,
    List<String>? boundingbox,
    String? lat,
    String? lon,
    String? displayName,
    String? class2,
    String? type,
    double? importance,
    String? icon,
  }) =>
      MyLocation2(
        placeId: placeId ?? this.placeId,
        licence: licence ?? this.licence,
        osmType: osmType ?? this.osmType,
        osmId: osmId ?? this.osmId,
        boundingbox: boundingbox ?? this.boundingbox,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        displayName: displayName ?? this.displayName,
        class2: class2 ?? this.class2,
        type: type ?? this.type,
        importance: importance ?? this.importance,
        icon: icon ?? this.icon,
      );
}
