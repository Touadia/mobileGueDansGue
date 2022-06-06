import 'package:gue_dans_gue_mobile/Collecteur/message_collecteur.dart';
import 'package:gue_dans_gue_mobile/Profile/message_profile.dart';

class Profile {
  int? result;
  MessageProfile? message;

  Profile({this.result, this.message});

  Profile.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = MessageProfile.fromJson(json['message']);
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
