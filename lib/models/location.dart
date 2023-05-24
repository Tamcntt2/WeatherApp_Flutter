// api nominatim: get information city, country from lat, lon
class MyLocation {
  int? placeId;
  String? licence;
  String? osmType;
  int? osmId;
  String? lat;
  String? lon;
  int? placeRank;
  String? category;
  String? type;
  double? importance;
  String? addresstype;
  String? name;
  String? displayName;
  MyAddress? address;
  List<String>? boundingbox;

  MyLocation(
      {this.placeId,
      this.licence,
      this.osmType,
      this.osmId,
      this.lat,
      this.lon,
      this.placeRank,
      this.category,
      this.type,
      this.importance,
      this.addresstype,
      this.name,
      this.displayName,
      this.address,
      this.boundingbox});

  MyLocation.fromJson(Map<String, dynamic> json) {
    placeId = json["place_id"];
    licence = json["licence"];
    osmType = json["osm_type"];
    osmId = json["osm_id"];
    lat = json["lat"];
    lon = json["lon"];
    placeRank = json["place_rank"];
    category = json["category"];
    type = json["type"];
    importance = json["importance"];
    addresstype = json["addresstype"];
    name = json["name"];
    displayName = json["display_name"];
    address =
        json["address"] == null ? null : MyAddress.fromJson(json["address"]);
    boundingbox = json["boundingbox"] == null
        ? null
        : List<String>.from(json["boundingbox"]);
  }

  static List<MyLocation> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => MyLocation.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["place_id"] = placeId;
    _data["licence"] = licence;
    _data["osm_type"] = osmType;
    _data["osm_id"] = osmId;
    _data["lat"] = lat;
    _data["lon"] = lon;
    _data["place_rank"] = placeRank;
    _data["category"] = category;
    _data["type"] = type;
    _data["importance"] = importance;
    _data["addresstype"] = addresstype;
    _data["name"] = name;
    _data["display_name"] = displayName;
    if (address != null) {
      _data["address"] = address?.toJson();
    }
    if (boundingbox != null) {
      _data["boundingbox"] = boundingbox;
    }
    return _data;
  }

  MyLocation copyWith({
    int? placeId,
    String? licence,
    String? osmType,
    int? osmId,
    String? lat,
    String? lon,
    int? placeRank,
    String? category,
    String? type,
    double? importance,
    String? addresstype,
    String? name,
    String? displayName,
    MyAddress? address,
    List<String>? boundingbox,
  }) =>
      MyLocation(
        placeId: placeId ?? this.placeId,
        licence: licence ?? this.licence,
        osmType: osmType ?? this.osmType,
        osmId: osmId ?? this.osmId,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        placeRank: placeRank ?? this.placeRank,
        category: category ?? this.category,
        type: type ?? this.type,
        importance: importance ?? this.importance,
        addresstype: addresstype ?? this.addresstype,
        name: name ?? this.name,
        displayName: displayName ?? this.displayName,
        address: address ?? this.address,
        boundingbox: boundingbox ?? this.boundingbox,
      );
}

class MyAddress {
  String? amenity;
  String? houseNumber;
  String? road;
  String? neighbourhood;
  String? cityDistrict;
  String? city;
  String? iso31662Lvl4;
  String? postcode;
  String? country;
  String? countryCode;

  MyAddress(
      {this.amenity,
      this.houseNumber,
      this.road,
      this.neighbourhood,
      this.cityDistrict,
      this.city,
      this.iso31662Lvl4,
      this.postcode,
      this.country,
      this.countryCode});

  MyAddress.fromJson(Map<String, dynamic> json) {
    amenity = json["amenity"];
    houseNumber = json["house_number"];
    road = json["road"];
    neighbourhood = json["neighbourhood"];
    cityDistrict = json["city_district"];
    city = json["city"];
    iso31662Lvl4 = json["ISO3166-2-lvl4"];
    postcode = json["postcode"];
    country = json["country"];
    countryCode = json["country_code"];
  }

  static List<MyAddress> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => MyAddress.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["amenity"] = amenity;
    _data["house_number"] = houseNumber;
    _data["road"] = road;
    _data["neighbourhood"] = neighbourhood;
    _data["city_district"] = cityDistrict;
    _data["city"] = city;
    _data["ISO3166-2-lvl4"] = iso31662Lvl4;
    _data["postcode"] = postcode;
    _data["country"] = country;
    _data["country_code"] = countryCode;
    return _data;
  }

  MyAddress copyWith({
    String? amenity,
    String? houseNumber,
    String? road,
    String? neighbourhood,
    String? cityDistrict,
    String? city,
    String? iso31662Lvl4,
    String? postcode,
    String? country,
    String? countryCode,
  }) =>
      MyAddress(
        amenity: amenity ?? this.amenity,
        houseNumber: houseNumber ?? this.houseNumber,
        road: road ?? this.road,
        neighbourhood: neighbourhood ?? this.neighbourhood,
        cityDistrict: cityDistrict ?? this.cityDistrict,
        city: city ?? this.city,
        iso31662Lvl4: iso31662Lvl4 ?? this.iso31662Lvl4,
        postcode: postcode ?? this.postcode,
        country: country ?? this.country,
        countryCode: countryCode ?? this.countryCode,
      );
}
