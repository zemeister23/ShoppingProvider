import 'package:duration/duration.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPage extends StatefulWidget {
  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  late final AudioPlayer player;
  var duration;
  String audioUrl =
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';
  Icon iconPlay = const Icon(Icons.play_arrow);
  double _sliderDuration = 0;
  double _vaqt = 0;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setUrl(audioUrl).then((v) {
      duration = v;

      List d = v.toString().split(':');
      double soat = double.parse(d[0]);
      double daqiqa = double.parse(d[1]);
      double sekund = double.parse(d[2]);
      _vaqt = (soat * 3600) + (daqiqa * 60) + (sekund);
      setState(() {});
    });
    player.playingStream.listen((event) {
      if (event) {
        iconPlay = const Icon(Icons.pause);
      } else {
        iconPlay = const Icon(Icons.play_arrow);
      }
    });
    player.positionStream.listen((event) {
      List d = event.toString().split(':');
      double soat = double.parse(d[0]);
      double daqiqa = double.parse(d[1]);
      double sekund = double.parse(d[2]);
      double vaqt = (soat * 3600) + (daqiqa * 60) + (sekund);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("AUDIO DURATION: $duration"),
          Slider(
              value: _sliderDuration,
              min: 0,
              max: _vaqt,
              onChanged: (v) {
                _sliderDuration = v;
                player.seek(Duration(seconds: v.toInt()));
                setState(() {});
              }),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            mini: true,
            heroTag: '1',
            onPressed: () {
              if (player.playing) {
                player.pause();
              } else {
                player.play();
              }
              setState(() {});
            },
            child: iconPlay,
          ),
          FloatingActionButton(
            heroTag: '2',
            onPressed: () {
              player.stop();
              player.seek(const Duration(seconds: 0));
            },
            child: const Icon(Icons.stop),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    player.seek(const Duration(seconds: 0));
    super.dispose();
  }
}
