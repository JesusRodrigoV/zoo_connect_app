import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoader extends StatelessWidget {
  final double size;
  const CustomLoader({super.key, this.size = 150});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: LoadingAnimationWidget.newtonCradle(color: color, size: size),
    );
  }
}
