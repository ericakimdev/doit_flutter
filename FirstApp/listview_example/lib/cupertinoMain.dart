import 'package:flutter/cupertino.dart';
import 'animalItem.dart';
import 'iosSub/cupertinoFirstPage.dart';
import 'iosSub/cupertinoSecondPage.dart';

List<Animal> favoriteList = [];

class CupertinoMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CupertinoMain();
  }
}

class _CupertinoMain extends State<CupertinoMain> {
  CupertinoTabBar tabBar;
  List<Animal> animalList = [];

  @override
  void initState() {
    super.initState();
    tabBar = CupertinoTabBar(items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.add)),
    ]);

    animalList.add(
        Animal(animalName: "bee", kind: "bug", imagePath: "repo/images/bee.png"));
    animalList.add(Animal(
        animalName: "cat", kind: "mammal", imagePath: "repo/images/cat.png"));
    animalList.add(Animal(
        animalName: "cow", kind: "mammal", imagePath: "repo/images/cow.png"));
    animalList.add(Animal(
        animalName: "dog", kind: "mammal", imagePath: "repo/images/dog.png"));
    animalList.add(Animal(
        animalName: "fox", kind: "mammal", imagePath: "repo/images/fox.png"));
    animalList.add(Animal(
        animalName: "monkey", kind: "primates", imagePath: "repo/images/monkey.png"));
    animalList.add(Animal(
        animalName: "pig", kind: "mammal", imagePath: "repo/images/pig.png"));
    animalList.add(Animal(
        animalName: "wolf", kind: "mammal", imagePath: "repo/images/wolf.png"));

  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoTabScaffold(tabBar: tabBar, tabBuilder: (context , value){
        if(value == 0){
          return CupertinoFirstPage(animalList: animalList,);
        }else{
          return CupertinoSecondPage(animalList: animalList,);
        }
      }),
    );
  }
}