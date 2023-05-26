class MyAccount {
  String? email;
  String? firstName;
  String? lastName;
  String? photoUrl;
  String? uid;

  MyAccount(
      {this.email, this.firstName, this.lastName, this.photoUrl, this.uid});

  MyAccount.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
    photoUrl = json["photo_url"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["uid"] = uid;
    data["firstName"] = firstName;
    data["lastName"] = lastName;
    data["email"] = email;
    data["photo_url"] = photoUrl;
    return data;
  }
}
