import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

final player = AudioPlayer();
final bgAudio1 = AudioPlayer();
final bgAudio2 = AudioPlayer();


void playbgm1() {
  bgAudio1.setVolume(0.5);
  bgAudio1.play(
    AssetSource('musics/bgmformeny.mp3'),
  );
  bgAudio1.onPlayerComplete.listen((event) {
    bgAudio1.play(
      AssetSource('musics/bgmformeny.mp3'),
    );
  });
}

void playbgm2() {
  bgAudio2.play(
    AssetSource("shortmusic.mp3"),
  );
  bgAudio2.onPlayerComplete.listen((event) {
    bgAudio2.play(
      AssetSource("shortmusic.mp3"),
    );
  });
}
