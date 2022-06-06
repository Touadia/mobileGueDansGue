class Position {
  Null deletedAt;
  int? id;
  String? nom;
  String? statut;
  double? longitude;
  double? latitude;
  String? createdAt;
  String? updatedAt;

  Position(
      {this.deletedAt,
      this.id,
      this.nom,
      this.statut,
      this.longitude,
      this.latitude,
      this.createdAt,
      this.updatedAt});

  Position.fromJson(Map<String, dynamic> json) {
    deletedAt = json['deleted_at'];
    id = json['id'];
    nom = json['nom'];
    statut = json['statut'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deleted_at'] = this.deletedAt;
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['statut'] = this.statut;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
