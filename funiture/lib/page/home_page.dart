import 'package:flutter/material.dart';
import 'package:uidesign03/core/color.dart';
import 'package:uidesign03/core/space.dart';
import 'package:uidesign03/core/text_style.dart';
import 'package:uidesign03/data/model_data.dart';
import 'package:uidesign03/widgets/Custom_app_bar.dart';
import 'package:uidesign03/widgets/item_card.dart';
import 'package:uidesign03/widgets/tabbar_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(),
            Text(
              'hair style \nsmaple App',
              style: heading,
            ),
            SpaceVH(height: 20),
            Container(
              height: 70.0,
              child: TabBarButton(),
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      childAspectRatio: 1,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10),
                  physics: BouncingScrollPhysics(),
                  itemCount: models.length,
                  itemBuilder: (builder, index) {
                    final model = models[index];
                    print(index);
                    return ItemCard(model: model);
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        child: Container(
          padding: EdgeInsets.only(bottom: 6),
          height: 50.0,
          color: Colors.white,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    bottomNavButton(
                      onPress: () {},
                      icon: Icons.home_sharp,

                    ),
                    SpaceVH(width: 60),
                    bottomNavButton(
                      onPress: () {},
                      icon: Icons.search,
                    ),
                    SpaceVH(width: 60),
                    bottomNavButton(
                      onPress: () {},
                      icon: Icons.person_outline_outlined,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconButton bottomNavButton(
      {required Function() onPress, required IconData icon}) {
    return IconButton(
      onPressed: onPress,
      icon: Icon(
        icon,
        size: 40,
        color: Colors.black,
      ),
    );
  }
}
