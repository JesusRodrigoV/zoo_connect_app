import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/providers/settings/sound_provider.dart';

class FeedbackService {
  final Ref _ref;
  late final AudioPlayer _player;

  FeedbackService(this._ref) {
    _player = AudioPlayer();
    _player.setVolume(0.3);
  }

  Future<void> provideCorrectFeedback() async {
    HapticFeedback.lightImpact();
    final isSoundEnabled = _ref.read(soundProvider);
    if (isSoundEnabled) {
      try {
        await _player.play(AssetSource('sounds/correct.mp3'));
      } catch (e) {
        // Fallback silencioso
      }
    }
  }

  Future<void> provideIncorrectFeedback() async {
    HapticFeedback.heavyImpact();
    HapticFeedback.vibrate();
    final isSoundEnabled = _ref.read(soundProvider);
    if (isSoundEnabled) {
      try {
        await _player.play(AssetSource('sounds/incorrect.mp3'));
      } catch (e) {
        // Fallback silencioso
      }
    }
  }

  void dispose() {
    _player.dispose();
  }
}

final feedbackServiceProvider = Provider<FeedbackService>((ref) {
  final service = FeedbackService(ref);
  ref.onDispose(() => service.dispose());
  return service;
});
