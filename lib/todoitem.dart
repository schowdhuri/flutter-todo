import 'package:flutter/material.dart';

class TodoItem extends StatefulWidget {
  TodoItem(this.title, {Key key}) : super(key: key);
  final String title;

  @override
  _TodoItemState createState() => _TodoItemState(title);
}

class _TodoItemState extends State<TodoItem> {
  _TodoItemState(this.title) : super();

  final String title;
  bool _isComplete = false;

  toggle() {
    setState(() {
      _isComplete = !_isComplete;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          leading: Checkbox(
            checkColor: Colors.white,
            activeColor: Colors.lightGreen[500],
            value: _isComplete,
            onChanged: (val) {},
          ),
          title: Text(title),
        ),
      ),
      onTap: toggle,
    );
  }
}
