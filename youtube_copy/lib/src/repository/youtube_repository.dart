import 'package:get/get.dart';
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
      if(respones.body['items'].length > 0) {
        return YoutubeVideoResult.fromJson(respones.body);
      }else{
        return YoutubeVideoResult.fromJson(respones.body);
      }
    }
  }
}