import 'package:byc/model/designer_info_model.dart';
import 'package:byc/view/designer_detail_view.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesignerSummaryWidget extends StatelessWidget {
  DesignerSummaryWidget({Key? key, required this.designerInfoModel})
      : super(key: key);

  DesignerInfoModel designerInfoModel;

  @override
  Widget build(BuildContext context) {
    int? index = designerInfoModel.index;
    String? name = designerInfoModel.name;
    String? shop = designerInfoModel.shop;
    int? year = designerInfoModel.year;

    return GestureDetector(
      onTap: () {
        Get.to(() => DesignerDetailView(designerInfoModel: designerInfoModel));
        print(index);
      },
      child: ArticleWidget(),
    );
  }
}

class ArticleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      header: Text('article.title'),
      collapsed: Text(
        'article.body',
        softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      expanded: Text(
        'article.body',
        softWrap: true,
      ),
    );
  }
}
