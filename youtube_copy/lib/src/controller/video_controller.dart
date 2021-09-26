import 'package:get/get.dart';
import 'package:youtube_copy/src/models/statistics.dart';
import 'package:youtube_copy/src/models/video.dart';
import 'package:youtube_copy/src/repository/youtube_repository.dart';

class VideoController extends GetxController{

  Video video;
  VideoController({required this.video});
  Rx<Statistics> statistics = Statistics(viewCount: "viewCount", likeCount: "likeCount", dislikeCount: "dislikeCount", favoriteCount: "favoriteCount", commentCount: "commentCount").obs;

  @override
  void onInit() async{
    // TODO: implement onInit
    Statistics loadStatistics = await YoutubeRepository.to.getVideoInfoById(video.id.videoId);
    statistics(loadStatistics);
    super.onInit();
  }
}