class HistoriqueAchat {
  int? result;
  List<Message>? message;

  HistoriqueAchat({this.result, this.message});

  HistoriqueAchat.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['message'] != null) {
      // ignore: deprecated_member_use
      //message = new List<Message>();
      json['message'].forEach((i) {
        message!.add(new Message.fromJson(i));
      });
    } else {
      //message = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.message != null) {
      data['message'] = this.message!.map((i) => i.toJson()).toList();
    }
    return data;
  }
}

class Message {
  String? date;
  int? montant;
  int? prixUnitaire;
  int? quantite;
  String? nom;

  Message(
      {this.date, this.montant, this.prixUnitaire, this.quantite, this.nom});

  Message.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    montant = json['montant'];
    prixUnitaire = json['prix_unitaire'];
    quantite = json['quantite'];
    nom = json['nom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['montant'] = this.montant;
    data['prix_unitaire'] = this.prixUnitaire;
    data['quantite'] = this.quantite;
    data['nom'] = this.nom;
    return data;
  }
}
