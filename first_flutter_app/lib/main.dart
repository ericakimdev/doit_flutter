import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    print('createState');
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  var switchValue = false;
  String test = 'hello'; //text for Button
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    print('build');
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData.light(),
        home: Scaffold(
            body: Center(
              child: RaisedButton(
                child: Text('$test'),
                color: _color,
                  onPressed: () {
                    if (_color == Colors.blue) {
                      setState(() {
                        test = 'flutter';
                        _color = Colors.amber;
                      });
                    } else {
                      setState(() {
                        test = 'flutter';
                        _color = Colors.blue;
                      });
                    }
                  }),
            )));
  }

  @override
  void initState() {
    super.initState();
    print('initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }
}

