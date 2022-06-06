class HistoriqueDepot {
  int? result;
  List<Message>? message;

  HistoriqueDepot({this.result, this.message});

  HistoriqueDepot.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['message'] != null) {
      //message = new List<Message>();
      json['message'].forEach((v) {
        message!.add(new Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  String? date;
  int? poids;
  String? nom;

  Message({this.date, this.poids, this.nom});

  Message.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    poids = json['poids'];
    nom = json['nom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['poids'] = this.poids;
    data['nom'] = this.nom;
    return data;
  }
}
