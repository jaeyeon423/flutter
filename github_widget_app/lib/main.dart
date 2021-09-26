import 'package:flutter/material.dart';
import 'package:github/github.dart';

void main ()=> runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState(){
    // TODO: implement initState
    getGithub();
    super.initState();
  }

  void getGithub() async{
    var github = GitHub(auth: Authentication.basic('jaeyeon423@gmail.com', 'yjk920423'));
    Repository repo = await github.repositories.getRepository(RepositorySlug('user_or_org', 'repo_name'));
    print(repo)


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
      ),
    );
  }
}
