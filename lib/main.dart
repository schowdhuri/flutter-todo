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

  Future<void> fetchTodos() async {
    await dao.connect();
    List<TodoModel> todos = await dao.findTodos();
    setState(() {
      _todos = todos;
    });
  }

  addTodo(String todo) async {
    final TodoModel todoModel = TodoModel(name: todo, isComplete: false);
    int todoId = await dao.addTodo(todoModel);
    todoModel.id = todoId;
    setState(() {
      _todos.insert(0, todoModel);
    });
  }

  removeTodo(TodoModel todo) async {
    await dao.removeTodo(todo);
    setState(() {
      _todos.remove(todo);
    });
  }

  toggleTodo(TodoModel todo) async {
    todo.isComplete = !todo.isComplete;
    await dao.saveTodo(todo);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  Widget buildTodoRow(BuildContext ctx, int index) {
    return TodoItem(
      _todos[index],
      onDelete: removeTodo,
      onToggle: toggleTodo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Todo",
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              "Todo",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.lightGreen[700],
          ),
          body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  NewTodo(addTodo),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: _todos.length,
                      itemBuilder: buildTodoRow,
                    ),
                  ),
                ]),
          ),
        ));
  }
}
