import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/data.dart';

class TodoItem extends StatefulWidget {
  TodoItem(this.todo, {this.onDelete, this.onToggle, key}) : super(key: key);
  final TodoModel todo;
  final onDelete;
  final onToggle;

  @override
  _TodoItemState createState() => _TodoItemState(
        todo,
        onDelete: onDelete,
        onToggle: onToggle,
      );
}

class _TodoItemState extends State<TodoItem> {
  final TodoModel todo;
  final onDelete;
  final onToggle;

  _TodoItemState(this.todo, {this.onDelete, this.onToggle}) : super();

  handleDelete() {
    onDelete(todo);
  }

  handleToggle() {
    onToggle(todo);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleToggle,
      child: ListTile(
        leading: Checkbox(
          checkColor: Colors.white,
          activeColor: Colors.lightGreen[500],
          value: todo.isComplete,
          onChanged: (val) {
            handleToggle();
          },
        ),
        title: Text(
          todo.name,
          style: todo.isComplete
              ? TextStyle(
                  color: Colors.blueGrey,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.lineThrough,
                )
              : null,
        ),
        trailing: IconButton(
          color: Colors.red[700],
          icon: Icon(Icons.delete_outline),
          onPressed: handleDelete,
        ),
      ),
    );
  }
}
