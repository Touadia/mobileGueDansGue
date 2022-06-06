import 'package:gue_dans_gue_mobile/Collecteur/message_collecteur.dart';

class Collecteur {
  int? result;
  MessageCollecteur? message;

  Collecteur({this.result, this.message});

  Collecteur.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = MessageCollecteur.fromJson(json['message']);
    /*!= null
        ? new MessageCollecteur.fromJson(json)
        : null;*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}
