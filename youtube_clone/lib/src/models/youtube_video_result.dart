import 'package:youtube_clone/src/models/video.dart';

class YoutubeVideoResult {
  int totalResults;

  int resultsPerPage;
  String nextPagetoken;
  List<Video> items;

  YoutubeVideoResult(
      {required this.totalResults,
      required this.resultsPerPage,
      required this.nextPagetoken,
      required this.items});

  factory YoutubeVideoResult.fromJson(Map<String, dynamic> json) =>
      YoutubeVideoResult(
          totalResults: json["pageInfo"]["totalResults"],
          resultsPerPage: json["pageInfo"]["resultsPerPage"],
          nextPagetoken: json["nextPageToken"],
          items: List<Video>.from(json["items"].map((data) => Video.fromJson(data))));
}
