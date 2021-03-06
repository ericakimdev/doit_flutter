import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'addTodo.dart';
import 'clearList.dart';
import 'todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase(); // save database

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => DatabaseApp(database),
        '/add': (context) => AddTodoApp(database),
        '/clear': (context) => ClearListApp(database)
      },
    );
  }

  // open and return database and if table not exist then create a table
  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, "
              "title TEXT, content TEXT, active BOOL)",
        );
      },
      version: 1,
    );
  }
}

class DatabaseApp extends StatefulWidget {
  final Future<Database> db;
  DatabaseApp(this.db);
  @override
  State<StatefulWidget> createState() => _DatabaseApp();
}

class _DatabaseApp extends State<DatabaseApp> {
  Future<List<Todo>> todoList;

  @override
  void initState() {
    super.initState();
    todoList = getTodos(); //save updated todolist
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Database Example'), actions: <Widget>[
          FlatButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed('/clear');
                setState(() {
                  todoList = getTodos();
                });
              },
              child: Text('Completed todo',style: TextStyle(color: Colors.white),))
        ]),
        body: Container(
          child: Center(
            child: FutureBuilder(
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return CircularProgressIndicator();
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  case ConnectionState.active:
                    return CircularProgressIndicator();
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          Todo todo = snapshot.data[index];
                          return ListTile(
                            title: Text(todo.title,style: TextStyle(fontSize: 20),),
                            subtitle: Container(
                              child: Column(children: <Widget>[
                                  Text(todo.content),
                                  Text('Check : ${todo.active.toString()}'),
                                  Container(height: 1,color: Colors.blue,)
                                ],
                              ),
                            ),
                            onTap: () async {
                              TextEditingController controller = new TextEditingController(text: todo.content);

                              Todo result = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('${todo.id} : ${todo.title}'),
                                      //content: Text('Check Todo?'),
                                      content: TextField(controller: controller, keyboardType: TextInputType.text,),
                                      actions: <Widget>[
                                        FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                todo.active == true
                                                    ? todo.active = false
                                                    : todo.active = true;
                                                todo.content = controller.value.text;
                                              });
                                              Navigator.of(context).pop(todo); //send data
                                            },
                                            child: Text('Yes')),
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('No')),
                                      ],
                                    );
                                  });
                              if (result != null) {
                                _updateTodo(result); //call updateTodo to update data
                              }
                            },
                            onLongPress: () async {
                              Todo result = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('${todo.id} : ${todo.title}'),
                                      content: Text('Delete ${todo.content}?'),
                                      actions: <Widget>[
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(todo);
                                            },
                                            child: Text('Yes')),
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('No')),
                                      ],
                                    );
                                  });
                              if (result != null) {
                                _deleteTodo(result);
                              }
                            },
                          );
                        },
                        itemCount: snapshot.data.length,
                      );
                    } else {
                      return Text('No data');
                    }
                }
                return CircularProgressIndicator();
              },
              future: todoList,
            ),
          ),
        ),
        floatingActionButton: Column(
          children: <Widget>[
            FloatingActionButton(
              onPressed: () async {
                final todo = await Navigator.of(context).pushNamed('/add');
                if (todo != null) {
                  _insertTodo(todo);
                }
              },
              heroTag: null,
              child: Icon(Icons.add),
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: () async {
                _allUpdate();
              },
              heroTag: null,
              child: Icon(Icons.update),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ));
  }

  void _allUpdate() async {
    final Database database = await widget.db;
    await database.rawUpdate('update todos set active = 1 where active = 0');
    setState(() {
      todoList = getTodos();
    });
  }

  void _deleteTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.delete('todos', where: 'id=?', whereArgs: [todo.id]);
    setState(() {
      todoList = getTodos(); //after deleting, update the current todo list
    });
  }

  void _updateTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.update(
      'todos',
      todo.toMap(),
      where: 'id = ? ', //which data will be updated
      whereArgs: [todo.id], //find udpate data using id
    );
    setState(() {
      todoList = getTodos();
    });
  }

  void _insertTodo(Todo todo) async {
    //declare db obj
    final Database database = await widget.db; //can use db variable in StatefulWidget with widget
    await database.insert('todos', todo.toMap(), //todos: name of table
        conflictAlgorithm: ConflictAlgorithm.replace); //to prevent conflict. to change it new data
    setState(() {
      todoList = getTodos();
    });
  }

  Future<List<Todo>> getTodos() async {
    final Database database = await widget.db; //using widget to get db variable in StatefulWidget
    final List<Map<String, dynamic>> maps = await database.query('todos'); //get table and add into maps

    return List.generate(maps.length, (i) {
      bool active = maps[i]['active'] == 1 ? true : false;
      return Todo(
          title: maps[i]['title'].toString(),
          content: maps[i]['content'].toString(),
          active: active,
          id: maps[i]['id']);
    });
  }
}
