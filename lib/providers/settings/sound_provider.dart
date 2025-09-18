import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundNotifier extends StateNotifier<bool> {
  SoundNotifier() : super(true) {
    _loadSoundSetting();
  }

  static const _soundKey = 'sound_enabled';

  void _loadSoundSetting() async {
    final prefs = await SharedPreferences.getInstance();
    final isSoundEnabled = prefs.getBool(_soundKey) ?? true;
    state = isSoundEnabled;
  }

  void setSound(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_soundKey, isEnabled);
    state = isEnabled;
  }
}

final soundProvider = StateNotifierProvider<SoundNotifier, bool>((ref) {
  return SoundNotifier();
});
