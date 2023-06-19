class LocalNotification {
  String? title;
  int? time;
  String? describe;

  LocalNotification({this.title, this.time, this.describe});

  LocalNotification.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    time = json["time"];
    describe = json["describe"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["title"] = title;
    data["time"] = time;
    data["describe"] = describe;
    return data;
  }
}
