import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'todo.dart';

class AddTodoApp extends StatefulWidget {
  final Future<Database> db;
  AddTodoApp(this.db);
  @override
  State<StatefulWidget> createState() => _AddTodoApp();
}

class _AddTodoApp extends State<AddTodoApp> {
  TextEditingController titleController;
  TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = new TextEditingController();
    contentController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: contentController,
                  decoration: InputDecoration(labelText: 'Content'),
                ),
              ),
              RaisedButton(
                onPressed: (){
                  Todo todo = Todo(
                      title: titleController.value.text,
                      content: contentController.value.text,
                      active: false);
                  Navigator.of(context).pop(todo);
                },
                child: Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
