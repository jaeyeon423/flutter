import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_copy/src/components/custom_appbar.dart';
import 'package:youtube_copy/src/components/video_widget.dart';
import 'package:youtube_copy/src/controller/home_controller.dart';

class Home extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => CustomScrollView(
          slivers: [
            SliverAppBar(
              title: CustomAppBar(),
              floating: true,
              snap: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed('/detail/123123');
                    },
                    child: VideoWidget(video : controller.youtubeResult.value.items[index]),
                  );
                },
                childCount: controller.youtubeResult.value.items.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
