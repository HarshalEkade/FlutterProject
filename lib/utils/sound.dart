import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class Sound {
  static final AudioPlayer _player = AudioPlayer();

  static void playFlip() {
    const file = kIsWeb ? 'sounds/flip.ogg' : 'sounds/flip.mp3';
    _player.play(AssetSource(file));
  }

  static void playMatch() {
    const file = kIsWeb ? 'sounds/match.ogg' : 'sounds/match.mp3';
    _player.play(AssetSource(file));
  }
}
