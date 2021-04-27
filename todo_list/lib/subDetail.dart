import 'package:flutter/material.dart';

class SubDetail extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SubDetail();
}

class _SubDetail extends State<SubDetail>{
  List<String> todoList = [];

  @override
  void initState() {
    super.initState();
    todoList.add('Buy carrots');
    todoList.add('Get medicine');
    todoList.add('Clean the room');
    todoList.add('Call to the parents');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Detail Example'),
      ),
      body: ListView.builder(itemBuilder: (context, index){
        return Card(
          child: InkWell(
            child: Text(todoList[index], style: TextStyle(fontSize: 30),) ,
            onTap: (){
              Navigator.of(context).pushNamed('/third' , arguments: todoList[index]);
            },
          ),
        );
      }, itemCount: todoList.length,
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        _addNavigation(context);
      }, child: Icon(Icons.add),
      ),
    );
  }
  void _addNavigation(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed('/second');
    setState(() {
      todoList.add(result);
    });
  }

}
