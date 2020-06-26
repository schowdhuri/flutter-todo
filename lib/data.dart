import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoModel {
  final int id;
  final String name;
  final bool isComplete;

  TodoModel({
    this.id,
    this.name,
    this.isComplete,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "name": this.name,
      "isComplete": this.isComplete ? 1 : 0,
    };
  }
}

class DAO {
  Future<Database> database;
  Future<void> connect() async {
    database = openDatabase(
      join(await getDatabasesPath(), "todolist.db"),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todo ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name TEXT,"
          "iscomplete INTEGER"
          ")",
        );
      },
      version: 1,
    );
  }

  addTodo(TodoModel todo) async {
    final Database db = await database;
    await db.insert("todo", todo.toMap());
  }

  Future<List<TodoModel>> findTodos() async {
    final Database db = await database;
    final List<Map<String, dynamic>> rows = await db.query("todo");
    return List.generate(rows.length, (index) {
      return TodoModel(
        id: rows[index]["id"],
        name: rows[index]["name"],
        isComplete: rows[index]["iscomplete"] == "1" ? true : false,
      );
    });
  }
}
