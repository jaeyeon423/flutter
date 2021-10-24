import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uidesign03/api/storage_service.dart';
import 'package:uidesign03/core/color.dart';
import 'package:uidesign03/core/text_style.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DesignerPage extends StatefulWidget {
  final String designer_id;

  const DesignerPage({Key? key, required this.designer_id}) : super(key: key);

  @override
  _DesignerPageState createState() => _DesignerPageState();
}

class _DesignerPageState extends State<DesignerPage> {
  int selectIndex = 0;
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "디자이너 페이지",
          style: itemCardHeading,
        ),
        actions: [],
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final results = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.custom,
                  allowedExtensions: ['png', 'jpg'],
                );
                if (results == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("no file selected")));
                  return null;
                }
                final path = results.files.single.path!;
                final fileName = results.files.single.name;

                print(path);
                print(fileName);

                storage
                    .uploadFile(path, fileName)
                    .then((value) => print("done"));
              },
              child: Text("Upload file"),
            ),
          ),
          FutureBuilder(
            future: storage.listFiles(),
            builder: (BuildContext context,
                AsyncSnapshot<firebase_storage.ListResult> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(onPressed: (){}, child: Text(snapshot.data!.items[index].name),),
                      );
                    },
                  ),
                );
              } else {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Container();
              }
            },
          ),
          FutureBuilder(
            future: storage.downloadURL('s01.png'),
            builder: (BuildContext context,
                AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Container(
                  height: 300,
                  width: 250,
                  child: Image.network(snapshot.data!, fit: BoxFit.cover,),
                );
              } else {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
