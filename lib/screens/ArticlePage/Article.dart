import 'package:flutter/material.dart';
//import 'package:gue_dans_gue/Couleurs/AppColors.dart';

class Article {
  final String image, titre, description;
  final int prix, size, id;
  final Color color;
  Article({
    required this.id,
    required this.image,
    required this.titre,
    required this.prix,
    required this.description,
    required this.size,
    required this.color,
  });
}

List<Article> articles = [
  Article(
      id: 1,
      titre: "Assiette mauve",
      prix: 50,
      size: 12,
      description:
          "Assiette très solide et résistante. \nPour tous vos repas et même vous événements.\nPratique et passe partout!",
      image: 'images/assiette_mauve.png',
      color: Colors.white),
  Article(
    id: 2,
    titre: "Coque pour téléphone Samsung Galaxy S10+",
    prix: 35,
    size: 7,
    description:
        "Coque pour téléphone Samsung Galaxy S10+. \nNe craignez plus les fissures ou les raillures. Votre téléphone est maintenant en sécurité!",
    image: 'images/coque_SAMSUNG_Galaxy_S10P_orangr.png',
    color: Colors.white,
  ),
  Article(
    id: 3,
    titre: "Peigne démélant",
    prix: 25,
    size: 7,
    description:
        "Peigne pour cheveux crépu, démélant. Vous n'aurez plus de mal à peinger vos cheveux. Ils seront facile à peigner, doux et resplondissants.",
    image: 'images/Peigne_demeloir.png',
    color: Colors.white,
  ),
  Article(
    id: 4,
    titre: "Support de telephone",
    prix: 25,
    size: 7,
    description:
        "Facilitez l'utilisation de vos téléphone grace à ce support. Vous n'aurez plus à le tenir à chaque fois. Ce support est tout ce qui vous manquait! ",
    image: 'images/support_telephone.png',
    color: Colors.white,
  ),
  Article(
    id: 5,
    titre: "Pot de fleur Gué dans Gué",
    prix: 65,
    size: 12,
    description:
        "Décorez vos maisons avec de beaux pots de fleurs. Rapprochez vous de la nature et de la beauté ultime!",
    image: 'images/pot_de_fleur.png',
    color: Colors.white,
  ),
];
