import 'dart:io';
import 'dart:typed_data';
import 'package:exampleapp/service/video_service.dart';
import 'package:exampleapp/video/video_page.dart';
import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';
import 'package:internet_file/storage_io.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:path_provider/path_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final storageIO = InternetFileStorageIO();
  String videoUrl =
      'https://jsoncompare.org/LearningContainer/SampleFiles/Video/MP4/Sample-Video-File-For-Testing.mp4';
  double percent = 0;
  int currentIndex = 0;
  String? offlineUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: VideoService().getVideos(),
            builder: (context, AsyncSnapshot snap) {
              if (!snap.hasData) {
                return CircularProgressIndicator();
              } else if (snap.hasError) {
                return Text("ERROR INTERNET !");
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: IconButton(
                          icon: const Icon(Icons.play_arrow),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoPage(
                                  url: snap.data[index]['url'],
                                  isOffline: false,
                                ),
                              ),
                            );
                          },
                        ),
                        title: Text(
                          snap.data[index]['name'],
                        ),
                        trailing: IconButton(
                          icon: percent >= 100
                              ? const Icon(Icons.play_arrow)
                              : const Icon(Icons.download),
                          onPressed: percent >= 100
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VideoPage(
                                        url: offlineUrl,
                                        isOffline: true,
                                      ),
                                    ),
                                  );
                                }
                              : () async {
                                  await downloadTheFile(
                                      snap.data[index]['url']);
                                  setState(() {});
                                },
                        ),
                      ),
                    );
                  },
                  itemCount: snap.data.length,
                );
              }
            },
          )),
          Expanded(
              child: Center(
            child: SizedBox(
              height: 300,
              width: 150,
              child: LiquidLinearProgressIndicator(
                value: percent * 0.01,
                valueColor: AlwaysStoppedAnimation(Colors.yellow),
                backgroundColor: Colors.white,
                borderColor: Colors.black,
                borderWidth: 5.0,
                direction: Axis.vertical,
                center: Text(
                  "Downloading: ${percent.toStringAsFixed(1)} %",
                  style: TextStyle(color: Colors.red),
                ),
                borderRadius: 12.0,
              ),
            ),
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await downloadTheFile(videoUrl);
        },
        child: const Icon(Icons.download),
      ),
    );
  }

  Future downloadTheFile(String url) async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    debugPrint(appDocDirectory.path);
    final Uint8List bytes = await InternetFile.get(
      url,
      storage: storageIO,
      process: (percentage) {
        // debugPrint('downloadPercentage: $percentage %');
        setState(() {
          percent = percentage;
        });
      },
      storageAdditional: {
        'filename': url.split('/').last.toString(),
        'location': appDocDirectory.path,
      },
    );
    offlineUrl =
        appDocDirectory.path + '/' + url.split('/').last.toString();
    debugPrint(offlineUrl.toString());
  }
}
