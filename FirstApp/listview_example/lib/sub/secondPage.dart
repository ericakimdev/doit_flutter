import 'package:flutter/material.dart';
import '../animalItem.dart';

class SecondApp extends StatefulWidget{
  List<Animal> list; // Animal List
  SecondApp({Key key, @required this.list}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SecondApp();
}

class _SecondApp extends State<SecondApp> {
  final nameController = TextEditingController();
  int _radioValue = 0;
  bool flyExist = false;
  var _imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                maxLines: 1,
              ),
              Row(children: <Widget>[
                  Radio(value: 0, groupValue: _radioValue, onChanged: _radioChange),
                  Text('amphibian'),
                  Radio(value: 1, groupValue: _radioValue, onChanged: _radioChange),
                  Text('reptile'),
                  Radio(value: 2, groupValue: _radioValue, onChanged: _radioChange),
                  Text('mammal'),
              ], mainAxisAlignment: MainAxisAlignment.spaceAround),
              Row(children: <Widget>[
                Text('Can Fly?'),
                Checkbox(
                    value: flyExist,
                    onChanged: (check) {
                      setState(() {
                        flyExist = check;
                      });
                    })
              ], mainAxisAlignment: MainAxisAlignment.spaceAround),
              Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GestureDetector(
                      child: Image.asset('repo/images/cow.png', width: 80),
                      onTap: () {
                        _imagePath = 'repo/images/cow.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('repo/images/pig.png', width: 80),
                      onTap: () {
                        _imagePath = 'repo/images/pig.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('repo/images/bee.png', width: 80),
                      onTap: () {
                        _imagePath = 'repo/images/bee.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('repo/images/cat.png', width: 80),
                      onTap: () {
                        _imagePath = 'repo/images/cat.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('repo/images/fox.png', width: 80),
                      onTap: () {
                        _imagePath = 'repo/images/fox.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('repo/images/monkey.png', width: 80),
                      onTap: () {
                        _imagePath = 'repo/images/monkey.png';
                      },
                    ),
                  ],
                ),
              ),
              RaisedButton(
                  child: Text('Add animals'),
                  onPressed: () {
                    var animal = Animal(
                        animalName: nameController.value.text,
                        kind: getKind(_radioValue),
                        imagePath: _imagePath,
                        flyExist: flyExist);

                    AlertDialog dialog = AlertDialog(
                      title: Text('Add Animals'),
                      content: Text(
                        'This animal is ${animal.animalName}. The kind of this animal is ${animal.kind}.\n Do you want to add?',
                        style: TextStyle(fontSize: 30.0),
                      ),
                      actions: [
                        RaisedButton(onPressed: (){
                          widget.list.add(animal);
                          Navigator.of(context).pop();
                        } , child: Text('Yes'),),
                        RaisedButton(onPressed: (){
                          Navigator.of(context).pop();
                        } , child: Text('No'),),
                      ],
                    );
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => dialog);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  _radioChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }


  getKind(int radioValue) {
    switch (radioValue) {
      case 0:
        return "amphibian";
      case 1:
        return "reptile";
      case 2:
        return "mammal";
    }
  }
}