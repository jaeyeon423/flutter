import 'package:youtube_copy/src/models/video.dart';

class YoutubeVideoResult {
  int totalResults;
  int resultsPerPage;
  String nextPageToken;
  List<Video> items;

  YoutubeVideoResult(
      {required this.totalResults,
      required this.resultsPerPage,
      required this.nextPageToken,
      required this.items});

  factory YoutubeVideoResult.fromJson(Map<String, dynamic> json) =>
      YoutubeVideoResult(
          totalResults: json['pageInfo']['totalResults'],
          resultsPerPage: json['pageInfo']['resultsPerPage'],
          nextPageToken: json['nextPageToken'],
          items: List<Video>.from(
              json['items'].map((data) => Video.fromJson(data))));
}
