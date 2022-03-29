class Message {
  String? message;
  String? createdDateTime;
  int? fromUserId;
  int? toUserId;
  int? id;
  bool isSent = false;

  Message(
      {this.message,
      this.fromUserId,
      this.toUserId,
      this.createdDateTime,
      this.id});

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    fromUserId = json['fromUserId'];
    toUserId = json['toUserId'];
    createdDateTime = json['createdDateTime'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['fromUserId'] = fromUserId;
    data['toUserId'] = toUserId;
    data['createdDateTime'] = createdDateTime;
    data['id'] = id;
    return data;
  }
}
