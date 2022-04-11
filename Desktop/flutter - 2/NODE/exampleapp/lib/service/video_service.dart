import 'package:dio/dio.dart';

class VideoService {
  Future getVideos() async {
    Response res = await Dio().get('http://localhost:3000/video');
    return res.data;
  }
}
