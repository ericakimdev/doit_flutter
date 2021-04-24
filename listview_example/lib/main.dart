import 'package:flutter/material.dart';
import 'sub/firstPage.dart';
import 'sub/secondPage.dart';
import './animalItem.dart';
import './cupertinoMain.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CupertinoMain(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  TabController controller;
  //List<Animal> animalList = List();
  List<Animal> animalList = [];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);

    animalList.add(Animal(animalName: "bee", kind: "bug",
        imagePath: "repo/images/bee.png"));
    animalList.add(Animal(animalName: "cat", kind: "mammal",
        imagePath: "repo/images/cat.png"));
    animalList.add(Animal(animalName: "cow", kind: "mammal",
        imagePath: "repo/images/cow.png"));
    animalList.add(Animal(animalName: "dog", kind: "mammal",
        imagePath: "repo/images/dog.png"));
    animalList.add(Animal(animalName: "fox", kind: "mammal",
        imagePath: "repo/images/fox.png"));
    animalList.add(Animal(animalName: "monkey", kind: "primate",
        imagePath: "repo/images/monkey.png"));
    animalList.add(Animal(animalName: "pig", kind: "mammal",
        imagePath: "repo/images/pig.png"));
    animalList.add(Animal(animalName: "wolf", kind: "mammal",
        imagePath: "repo/images/wolf.png"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Listview Example'),
        ),
        body: TabBarView(
          children: <Widget>[FirstApp(list: animalList), SecondApp(list: animalList)],
          controller: controller,
        ),
        bottomNavigationBar: TabBar(tabs: <Tab>[
          Tab(icon: Icon(Icons.looks_one, color: Colors.blue),) ,
          Tab(icon: Icon(Icons.looks_two, color: Colors.blue),)
        ], controller: controller,
        )
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
