class MessageProfile {
  String? deletedAt;
  int? id;
  int? collecteurId;
  String? name;
  String? nom;
  String? prenom;
  String? userType;
  String? email;
  String? telephone;
  String? emailVerificatedAt;
  String? createdAt;
  String? updatedAt;
  int? solde;

  MessageProfile(
      {this.deletedAt,
      this.id,
      this.name,
      this.nom,
      this.collecteurId,
      this.prenom,
      this.userType,
      this.email,
      this.telephone,
      this.emailVerificatedAt,
      this.createdAt,
      this.updatedAt,
      this.solde});

  MessageProfile.fromJson(Map<String, dynamic> json) {
    deletedAt = json['deleted_at'];
    id = json['id'];
    name = json['name'];
    nom = json['nom'];
    collecteurId = json['collecteurId'];
    prenom = json['prenom'];
    userType = json['user_type'];
    email = json['email'];
    telephone = json['telephone'];
    emailVerificatedAt = json['email_verificated_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    solde = json['solde'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deleted_at'] = this.deletedAt;
    data['id'] = this.id;
    data['collecteurId'] = this.collecteurId;
    data['name'] = this.name;
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    data['user_type'] = this.userType;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['email_verificated_at'] = this.emailVerificatedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['solde'] = this.solde;
    return data;
  }
}
