import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Audio/Model/AudioDetialsResponseModel.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myott/UI/Audio/Controller/AudioController.dart';

class AudioPlayerController extends GetxController {
  final AudioPlayer player = AudioPlayer();
  final RxBool isPlaying = false.obs;
  final Rx<Duration> duration = Duration.zero.obs;
  final Rx<Duration> position = Duration.zero.obs;
  final RxBool isInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initAudioSession();
    _setupPlayerListeners();
  }

  Future<void> _initAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
  }

  void _setupPlayerListeners() {
    // Listen to player state changes
    player.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });

    // Listen to duration changes
    player.durationStream.listen((newDuration) {
      if (newDuration != null) {
        duration.value = newDuration;
      }
    });

    // Listen to position changes
    player.positionStream.listen((newPosition) {
      position.value = newPosition;
    });
  }

  Future<void> loadAudio(String? url) async {
    if (url != null && url.isNotEmpty) {
      await player.setUrl(url);
      isInitialized.value = true;
    }
  }

  Future<void> playPause() async {
    if (player.playing) {
      await player.pause();
    } else {
      await player.play();
    }
  }

  Future<void> seek(Duration position) async {
    await player.seek(position);
  }

  Future<void> seekForward() async {
    final newPosition = position.value + const Duration(seconds: 10);
    await player.seek(newPosition);
  }

  Future<void> seekBackward() async {
    final newPosition = position.value - const Duration(seconds: 10);
    await player.seek(newPosition);
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return duration.inHours > 0
        ? '$hours:$minutes:$seconds'
        : '$minutes:$seconds';
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
