class SendMessageRequest {
  String? message;
  int? toUserId;

  SendMessageRequest({this.message, this.toUserId});

  SendMessageRequest.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    toUserId = json['toUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['toUserId'] = toUserId;
    return data;
  }
}
