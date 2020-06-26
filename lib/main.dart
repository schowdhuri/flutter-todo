import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todoapp/newtodo.dart';
import 'package:todoapp/todoitem.dart';
import 'package:todoapp/data.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final DAO dao = DAO();
  List<TodoModel> _todos = [];
  Future<List<TodoModel>> _futureTodos;

  addTodo(String todo) async {
    final TodoModel todoModel = TodoModel(name: todo, isComplete: false);
    await dao.addTodo(todoModel);
    setState(() {
//      _todos.insert(0, todo);
    });
  }

  Widget getTodoRow(BuildContext ctx, int index) {
    return TodoItem(_todos[index].name, key: new Key("$_todos[index].id"));
  }

  Future<List<TodoModel>> fetchTodos() async {
    await dao.connect();
    return dao.findTodos();
  }

  @override
  void initState() {
    super.initState();
    _futureTodos = fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Todo App",
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              "Todo App",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.lightGreen[700],
          ),
          body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  NewTodo(addTodo),
                  FutureBuilder<List<TodoModel>>(
                    future: _futureTodos,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        updateTodos(snapshot.data);
                        return Expanded(
                          flex: 1,
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (ctx, index) {
                              return TodoItem(snapshot.data[index].name,
                                  key: new Key("$snapshot.data[index].id"));
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      // By default, show a loading spinner.
                      return CircularProgressIndicator();
                    },
                  ),
                ]),
          ),
        ));
  }
}
