import 'package:flutter/material.dart';
import 'package:todoapp/data.dart';

class TodoItem extends StatefulWidget {
  TodoItem(this.todo, {this.onDelete, this.onToggle})
      : super(key: Key("${todo.id}"));
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
      child: Card(
        child: ListTile(
          leading: Checkbox(
            checkColor: Colors.white,
            activeColor: Colors.lightGreen[500],
            value: todo.isComplete,
            onChanged: (val) {},
          ),
          title: Text(todo.name),
          trailing: IconButton(
            color: Colors.red[700],
            icon: Icon(Icons.delete_outline),
            onPressed: handleDelete,
          ),
        ),
      ),
      onTap: handleToggle,
    );
  }
}
