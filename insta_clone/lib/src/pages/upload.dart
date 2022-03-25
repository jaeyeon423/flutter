import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:insta_clone/src/components/image_data.dart';
import 'package:photo_manager/photo_manager.dart';

class Upload extends StatefulWidget {
  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  var albums = <AssetPathEntity>[];
  var headerTitle = '';
  var imageList = <AssetEntity>[];
  AssetEntity? selectedImage;

  Widget _imagePreview() {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: width,
      child: selectedImage == null
          ? Container()
          : _photoWidget(
              selectedImage!,
              width.toInt(),
              builder: (data) {
                return Image.memory(
                  data,
                  fit: BoxFit.cover,
                );
              },
            ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                          child: Container(
                        margin: const EdgeInsets.only(top: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black54,
                        ),
                        width: 40,
                        height: 4,
                      )),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              albums.length,
                                  (index) => Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                child: Text(albums[index].name),
                              ),
                            ),
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Text(
                    headerTitle,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: Color(0xff808080),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    ImageData(IconsPath.imageSelectIcon),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      "여러 항목 선택",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 7,
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff808080),
                ),
                child: ImageData(IconsPath.cameraIcon),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _imageSelectList() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 1,
        childAspectRatio: 1,
        crossAxisSpacing: 1,
      ),
      itemCount: imageList.length,
      itemBuilder: (BuildContext context, int index) {
        return _photoWidget(imageList[index], 200, builder: (data) {
          return GestureDetector(
            onTap: () {
              selectedImage = imageList[index];
              update();
            },
            child: Opacity(
              opacity: imageList[index] == selectedImage ? 0.3 : 1,
              child: Image.memory(
                data,
                fit: BoxFit.cover,
              ),
            ),
          );
        });
      },
    );
  }

  Widget _photoWidget(AssetEntity asset, int size,
      {required Widget Function(Uint8List) builder}) {
    return FutureBuilder(
        future: asset.thumbDataWithSize(size, size),
        builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
          if (snapshot.hasData) {
            return builder(snapshot.data!);
            return Opacity(
              opacity: asset == selectedImage ? 0.3 : 1,
              child: Image.memory(
                snapshot.data!,
                fit: BoxFit.cover,
              ),
            );
          } else {
            return Container();
          }
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPhoths();
  }

  void _loadPhoths() async {
    var result = await PhotoManager.requestPermissionExtend();

    if (result.isAuth) {
      albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
            imageOption: const FilterOption(
              sizeConstraint: SizeConstraint(minHeight: 100, minWidth: 100),
            ),
            orders: [
              const OrderOption(type: OrderOptionType.createDate, asc: false),
            ]),
      );
      _loadData();
    } else {}
  }

  void _loadData() async {
    headerTitle = albums.first.name;
    await _pagingPhotos();
    update();
  }

  Future<void> _pagingPhotos() async {
    var photos = await albums.first.getAssetListPaged(0, 36);
    imageList.addAll(photos);
    selectedImage = imageList.first;
  }

  void update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(
              IconsPath.closeImage,
              width: 50,
            ),
          ),
        ),
        title: Text(
          "New Post",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.nextImage,
                width: 50,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imagePreview(),
            _header(),
            _imageSelectList(),
          ],
        ),
      ),
    );
  }
}
