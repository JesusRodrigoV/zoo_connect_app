import 'package:flutter/material.dart';

class EdgeEffectController {
  final AnimationController edgeLightController;
  final AnimationController pulseController;
  late final Animation<double> edgeLightAnimation;
  late final Animation<double> pulseAnimation;

  Color _edgeColor = Colors.transparent;
  bool _showEdgeEffect = false;

  EdgeEffectController({
    required TickerProvider vsync,
  })  : edgeLightController = AnimationController(
          duration: const Duration(milliseconds: 1500),
          vsync: vsync,
        ),
        pulseController = AnimationController(
          duration: const Duration(milliseconds: 300),
          vsync: vsync,
        ) {
    
    edgeLightAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: edgeLightController,
      curve: Curves.easeOut,
    ));

    pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.03,
    ).animate(CurvedAnimation(
      parent: pulseController,
      curve: Curves.easeInOut,
    ));

    _setupListeners();
  }

  void _setupListeners() {
    edgeLightController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _showEdgeEffect = false;
        edgeLightController.reset();
      }
    });

    pulseController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        pulseController.reverse();
      }
    });
  }

  void triggerEffect(bool isCorrect) {
    _showEdgeEffect = true;
    _edgeColor = isCorrect 
      ? Colors.green.withAlpha(128) 
      : Colors.red.withAlpha(128);
    
    edgeLightController.forward();
    pulseController.forward();
  }

  Color get edgeColor => _edgeColor;
  bool get showEdgeEffect => _showEdgeEffect;

  void dispose() {
    edgeLightController.dispose();
    pulseController.dispose();
  }
}