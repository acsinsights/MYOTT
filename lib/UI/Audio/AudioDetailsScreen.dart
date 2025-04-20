import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Audio/Model/AudioDetialsResponseModel.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myott/UI/Audio/Controller/AudioController.dart';

import 'Components/customLoader.dart';
import 'controller/AudioPlayerController.dart';

class AudioDetailsScreen extends StatelessWidget {
  final String slug;

  AudioDetailsScreen({Key? key, required this.slug}) : super(key: key);

  final AudioController audioController = Get.find<AudioController>();
  final AudioPlayerController playerController = Get.put(AudioPlayerController());

  @override
  Widget build(BuildContext context) {
    // Fetch audio details when the screen loads
    _initializeData();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Audio Player'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (audioController.isLoading.value) {
          return const Center(child: CustomLoader());
        }

        final audioDetails = audioController.audioDetails.value;
        if (audioDetails == null) {
          return const Center(child: Text('No audio details found', style: TextStyle(color: Colors.white)));
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Audio Thumbnail and Player
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Audio thumbnail
                    CachedNetworkImage(
                      imageUrl: audioDetails.thumbnailImg ?? '',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(Icons.music_note, size: 80, color: Colors.grey),
                      ),
                    ),
                    // Dark overlay
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    // Play button
                    Obx(() => IconButton(
                      onPressed: playerController.playPause,
                      icon: Icon(
                        playerController.isPlaying.value ? Icons.pause_circle_filled : Icons.play_circle_fill,
                        size: 70,
                        color: Colors.white,
                      ),
                    )),
                  ],
                ),
              ),

              // Audio title
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  audioDetails.name ?? 'Unnamed Audio',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Audio controls
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    // Seekbar
                    Obx(() => SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 4,
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 14),
                        activeTrackColor: Colors.red,
                        inactiveTrackColor: Colors.grey[800],
                        thumbColor: Colors.red,
                        overlayColor: Colors.red.withOpacity(0.2),
                      ),
                      child: Slider(
                        value: playerController.position.value.inSeconds.toDouble(),
                        min: 0,
                        max: playerController.duration.value.inSeconds.toDouble() > 0 ?
                        playerController.duration.value.inSeconds.toDouble() : 1,
                        onChanged: (value) {
                          final newPosition = Duration(seconds: value.toInt());
                          playerController.seek(newPosition);
                        },
                      ),
                    )),

                    // Duration display
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            playerController.formatDuration(playerController.position.value),
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            playerController.formatDuration(playerController.duration.value),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )),
                    ),

                    SizedBox(height: 20),

                    // Player controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.replay_10, color: Colors.white, size: 28),
                          onPressed: playerController.seekBackward,
                        ),
                        Obx(() => IconButton(
                          icon: Icon(
                              playerController.isPlaying.value ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 40
                          ),
                          onPressed: playerController.playPause,
                        )),
                        IconButton(
                          icon: Icon(Icons.forward_10, color: Colors.white, size: 28),
                          onPressed: playerController.seekForward,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Audio details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),

                    Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      audioDetails.description ?? 'No description available',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),

                    SizedBox(height: 20),

                    Row(
                      children: [
                        _infoItem('Duration', audioDetails.durationTime ?? '--'),
                        _infoItem('Release', audioDetails.releaseYear?.split('-').first ?? '--'),
                        _infoItem('Maturity', audioDetails.maturity ?? '--'),
                      ],
                    ),

                    SizedBox(height: 20),

                    if ((audioDetails.cast?.actors?.length ?? 0) > 0)
                      _buildCastSection('Actors', audioDetails.cast!.actors!),

                    if ((audioDetails.cast?.directors?.length ?? 0) > 0)
                      _buildCastSection('Directors', audioDetails.cast!.directors!),

                    if ((audioDetails.cast?.genres?.length ?? 0) > 0)
                      _buildGenresSection('Genres', audioDetails.cast!.genres!),

                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Future<void> _initializeData() async {
    // Only fetch if not already loaded or different slug
    if (audioController.audioDetails.value == null ||
        audioController.audioDetails.value?.slug != slug) {
      await audioController.fetchAudioDetails(slug);
    }

    // Initialize audio player when audio details are available
    ever(audioController.audioDetails, (audioDetails) {
      if (audioDetails != null && !playerController.isInitialized.value) {
        playerController.loadAudio(audioDetails.audioUploadUrl);
      }
    });

    // If data is already available, initialize player
    if (audioController.audioDetails.value != null && !playerController.isInitialized.value) {
      playerController.loadAudio(audioController.audioDetails.value!.audioUploadUrl);
    }
  }

  Widget _infoItem(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCastSection(String title, List<dynamic> people) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: people.length,
            itemBuilder: (context, index) {
              final person = people[index];
              return Container(
                width: 80,
                margin: EdgeInsets.only(right: 12),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: CachedNetworkImage(
                        imageUrl: person.image ?? '',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[800],
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[800],
                          child: Icon(Icons.person, color: Colors.white70),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      person.name ?? '',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildGenresSection(String title, List<dynamic> genres) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: genres.map((genre) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                genre.name ?? '',
                style: TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}