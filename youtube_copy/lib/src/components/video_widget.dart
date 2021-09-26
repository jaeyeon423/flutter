import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_copy/src/controller/video_controller.dart';
import 'package:youtube_copy/src/models/video.dart';
import 'package:intl/intl.dart';

class VideoWidget extends StatefulWidget {
  final Video video;

  VideoWidget({required this.video});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoController _videoController;

  @override
  void initState() {
    _videoController = Get.put(VideoController(video: widget.video), tag: widget.video.id.videoId);
    super.initState();
  }

  Widget _thumbnail() {
    return Container(
      height: 250,
      color: Colors.grey.withOpacity(0.5),
      child: Image.network(
        widget.video.snippet.thumbnails.medium.url,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget _simpleDetailInfo() {
    return Container(
      padding: const EdgeInsets.only(left: 10, bottom: 15),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: Image.network(
                    "https://yt3.ggpht.com/ytc/AKedOLQagIEl2WOUacXZ8WlCPvApoIouP9sNGkMIDVdQ=s48-c-k-c0x00ffffff-no-rj")
                .image,
            radius: 30,
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      widget.video.snippet.title,
                      maxLines: 2,
                    )),
                    IconButton(
                      alignment: Alignment.topCenter,
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert,
                        size: 18,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      widget.video.snippet.channelTitle,
                      style: TextStyle(
                          fontSize: 12, color: Colors.black.withOpacity(0.8)),
                    ),
                    Text(" · "),
                    Obx(
                      () => Text(
                        "조회수는 ${_videoController.statistics.value.viewCount} ",
                        style: TextStyle(
                            fontSize: 12, color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    Text(" · "),
                    Text(
                      DateFormat("yyyy-MM-dd")
                          .format(widget.video.snippet.publishTime),
                      style: TextStyle(
                          fontSize: 12, color: Colors.black.withOpacity(0.6)),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _thumbnail(),
          _simpleDetailInfo(),
        ],
      ),
    );
  }
}