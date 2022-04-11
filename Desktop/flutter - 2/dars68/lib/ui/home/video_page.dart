import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController? videoPlayerController;

  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    _initChewie();
  }

  void _initChewie() {
    videoPlayerController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      looping: true,
      overlay: Align(
        alignment: Alignment.center,
        child: Text(
          "DIYOR PRODUCTION",
          style: TextStyle(
            backgroundColor: Colors.white.withOpacity(0.6),
            color: Colors.grey.withOpacity(0.08),
            fontSize: 30.0,
          ),
          maxLines: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 400,
          child: Chewie(
            controller: chewieController!,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    videoPlayerController!.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  Future init() async {
    await videoPlayerController!.initialize();
  }
}
