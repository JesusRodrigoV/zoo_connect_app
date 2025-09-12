import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget customLoader() {
  return Center(
    child: LoadingAnimationWidget.newtonCradle(
      color: const Color(0xFF1B5E20),
      size: 150,
    ),
  );
  /*
  return Center(
    child: LoadingAnimationWidget.discreteCircle(
      color: const Color(0xFF1B5E20),
      size: 50,
      secondRingColor: const Color(0xFF5D4037),
      thirdRingColor: const Color(0xFFFFC300), 
    ),
  );
  */
}
