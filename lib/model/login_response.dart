class LoginResponse {
  int? id;
  String? name;
  String? token;

  LoginResponse({this.id, this.name, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['token'] = token;
    return data;
  }
}
