//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gue_dans_gue_mobile/Couleurs/AppColors.dart';

//import 'package:gue_dans_gue/Couleurs/AppColors.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = AppColors.blue; //Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = Image.asset(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          width: 128,
          child: image,
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 0,
          child: IconButton(
            icon: Icon(Icons.edit),
            color: Colors.white,
            iconSize: 20,
            onPressed: onClicked,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
