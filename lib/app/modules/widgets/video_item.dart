import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoItem extends StatefulWidget {
  final String url;

  const VideoItem({Key? key, required, required this.url}) : super(key: key);

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late YoutubePlayerController youtubePlayerController;
  @override
  void initState() {
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: widget.url,
      flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          startAt: 0,
          showLiveFullscreenButton: true,
          controlsVisibleAtStart: true,
          disableDragSeek: true),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.url == '') {
      return Container(
        color: Colors.black,
        // width: 200,
        // height: 200,
        child: const Center(
          child: Text(
            "There is no trailer",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }
    print("url youtube : ${widget.url}");
    return YoutubePlayer(
      controller: youtubePlayerController,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.blueAccent,
      progressColors: const ProgressBarColors(
        playedColor: Colors.red,
        handleColor: Colors.blueAccent,
      ),
    );
  }

  @override
  void dispose() {
    youtubePlayerController.dispose();
    super.dispose();
  }
}
