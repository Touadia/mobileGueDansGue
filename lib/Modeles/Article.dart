import 'dart:convert';

Article articleFromJson(String str) => Article.fromJson(json.decode(str));

String articleToJson(Article data) => json.encode(data.toJson());

class Article {
  Article({
    this.deletedAt,
    this.id,
    this.nom,
    this.prixUnitaire,
    //this.image,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  String? deletedAt;
  int? id;
  String? nom;
  int? prixUnitaire;
  String? image;
  //Uint8List? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        deletedAt: json["deleted_at"],
        id: json["id"],
        nom: json["nom"],
        prixUnitaire: json["prix_unitaire"],
        //image: Image.memory(Uri.parse("data:image/png;base64,"+json["image"].replaceAll('/n'))),
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "deleted_at": deletedAt,
        "id": id,
        "nom": nom,
        "prix_unitaire": prixUnitaire,
        "image": image,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
