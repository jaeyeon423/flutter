import 'package:get/get.dart';
import 'package:youtube_clone/src/models/youtube_video_result.dart';

class YoutubeRepository extends GetConnect{
  static YoutubeRepository get to => Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    httpClient.baseUrl = "https://www.googleapis.com";
    super.onInit();
  }

  Future<YoutubeVideoResult> loadVideos() async{
    String url = "/youtube/v3/search?part=snippet&maxResults=10&order=date&type=video&key=AIzaSyAaMzzdhEnzcTk16ourljiP48IcLEAUepo";
    final response = await get(url);
    if(response.status.hasError){
      return Future.error(response.status.toString());
    }else{
      if(response.body["items"].length > 0){
        return YoutubeVideoResult.fromJson(response.body);
      }
      return YoutubeVideoResult.fromJson(response.body);
      print(response.body['items']);
    }
  }
}