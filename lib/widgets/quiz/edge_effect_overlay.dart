import 'package:flutter/material.dart';
import 'edge_effect_controller.dart';

class EdgeEffectOverlay extends StatelessWidget {
  final EdgeEffectController controller;

  const EdgeEffectOverlay({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (!controller.showEdgeEffect) return const SizedBox.shrink();

    return Stack(
      children: [
        _EdgeBorder(controller: controller),

        _ColorOverlay(controller: controller),

        ..._buildCornerEffects(),
      ],
    );
  }

  List<Widget> _buildCornerEffects() {
    const corners = [
      Alignment.topLeft,
      Alignment.topRight,
      Alignment.bottomLeft,
      Alignment.bottomRight,
    ];

    return corners
        .map(
          (alignment) =>
              _CornerGlow(controller: controller, alignment: alignment),
        )
        .toList();
  }
}

class _EdgeBorder extends StatelessWidget {
  final EdgeEffectController controller;

  const _EdgeBorder({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.edgeLightAnimation,
      builder: (context, child) {
        return Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: controller.edgeColor.withAlpha(
                  (controller.edgeLightAnimation.value * 0.9 * 255).round(),
                ),
                width: 5.0,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: controller.edgeColor.withAlpha(
                    (controller.edgeLightAnimation.value * 0.6 * 255).round(),
                  ),
                  blurRadius: 20.0,
                  spreadRadius: 8.0,
                ),
                BoxShadow(
                  color: controller.edgeColor.withAlpha(
                    (controller.edgeLightAnimation.value * 0.3 * 255).round(),
                  ),
                  blurRadius: 40.0,
                  spreadRadius: 15.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ColorOverlay extends StatelessWidget {
  final EdgeEffectController controller;

  const _ColorOverlay({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.edgeLightAnimation,
      builder: (context, child) {
        return Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: controller.edgeColor.withAlpha(
                (controller.edgeLightAnimation.value * 0.08 * 255).round(),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }
}

class _CornerGlow extends StatelessWidget {
  final EdgeEffectController controller;
  final Alignment alignment;

  const _CornerGlow({required this.controller, required this.alignment});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.edgeLightAnimation,
      builder: (context, child) {
        return Positioned(
          top: alignment.y < 0 ? 0 : null,
          bottom: alignment.y > 0 ? 0 : null,
          left: alignment.x < 0 ? 0 : null,
          right: alignment.x > 0 ? 0 : null,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  controller.edgeColor.withAlpha(
                    (controller.edgeLightAnimation.value * 0.4 * 255).round(),
                  ),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
