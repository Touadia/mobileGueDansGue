class ReponseAchat {
  int? result;
  String? message;

  ReponseAchat({this.result, this.message});

  ReponseAchat.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.message != null) {
      data['message'] = this.message;
    }
    return data;
  }
}
