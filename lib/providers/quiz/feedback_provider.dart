import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedbackService {
  late final AudioPlayer _player;
  
  FeedbackService() {
    _player = AudioPlayer();
    _player.setVolume(0.3);
  }

  Future<void> provideCorrectFeedback() async {
    HapticFeedback.lightImpact();
    try {
      await _player.play(AssetSource('sounds/correct.mp3'));
    } catch (e) {
      // Fallback silencioso si no hay archivo de sonido
    }
  }

  Future<void> provideIncorrectFeedback() async {
    HapticFeedback.heavyImpact();
    HapticFeedback.vibrate();
    try {
      await _player.play(AssetSource('sounds/incorrect.mp3'));
    } catch (e) {
      // Fallback silencioso si no hay archivo de sonido
    }
  }

  void dispose() {
    _player.dispose();
  }
}

final feedbackServiceProvider = Provider<FeedbackService>((ref) {
  final service = FeedbackService();
  ref.onDispose(() => service.dispose());
  return service;
});