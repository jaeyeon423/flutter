import 'package:get/get.dart';
import 'package:youtube_copy/src/models/statistics.dart';
import 'package:youtube_copy/src/models/youtube_video_result.dart';

class YoutubeRepository extends GetConnect{
  static YoutubeRepository get to => Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    httpClient.baseUrl = "https://www.googleapis.com";
    super.onInit();
  }

  Future<YoutubeVideoResult> loadVides() async{
    String url = "/youtube/v3/search?part=snippet&maxResults=10&order=date&type=video&key=AIzaSyAaMzzdhEnzcTk16ourljiP48IcLEAUepo";
    final respones = await get(url);
    if(respones.status.hasError) {
      return Future.error(respones.status);
    }else{
      return YoutubeVideoResult.fromJson(respones.body);
    }
  }

  Future<Statistics> getVideoInfoById(String videoId) async{
    String url = "/youtube/v3/videos?part=statistics&key=AIzaSyAaMzzdhEnzcTk16ourljiP48IcLEAUepo&id=VU3MBxr-TOc";
    final respones = await get(url);
    if(respones.status.hasError) {
      return Future.error(respones.status);
    }else{
      Map<String, dynamic> data = respones.body['items'][0];
      return Statistics.fromJson(data['statistics']);
    }
  }
}