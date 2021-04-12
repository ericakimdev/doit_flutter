import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  var switchValue = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData.light(),
        //home: MyHomePage(title: 'Flutter Demo Home Page'),
        // home: Container (
        //   color: Colors.white,
        //   child: Center(
        //     child: Text(
        //         'hello\nFlutter',
        //         textAlign: TextAlign.center,
        //         style: TextStyle(color: Colors.blue, fontSize: 20)),
        //   )
        // )
        home: Scaffold(
            body: Center(
              child: Switch(
              value: switchValue,
              onChanged: (value) {
                switchValue = value;
              }),
        )));
  }
}
