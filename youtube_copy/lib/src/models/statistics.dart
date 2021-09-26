import 'dart:convert';

Statistics statisticsFromJson(String str) => Statistics.fromJson(json.decode(str));

String statisticsToJson(Statistics data) => json.encode(data.toJson());

class Statistics {
  Statistics({
    required this.viewCount,
    required this.likeCount,
    required this.dislikeCount,
    required this.favoriteCount,
    required this.commentCount,
  });

  String viewCount;
  String likeCount;
  String dislikeCount;
  String favoriteCount;
  String commentCount;

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
    viewCount: json["viewCount"],
    likeCount: json["likeCount"],
    dislikeCount: json["dislikeCount"],
    favoriteCount: json["favoriteCount"],
    commentCount: json["commentCount"],
  );

  Map<String, dynamic> toJson() => {
    "viewCount": viewCount,
    "likeCount": likeCount,
    "dislikeCount": dislikeCount,
    "favoriteCount": favoriteCount,
    "commentCount": commentCount,
  };
}
