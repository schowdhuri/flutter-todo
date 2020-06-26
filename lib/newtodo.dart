import 'package:flutter/material.dart';

class NewTodo extends StatefulWidget {
  NewTodo(this.onSubmit, {Key key}) : super(key: key);
  final onSubmit;

  @override
  _NewTodoState createState() => _NewTodoState(onSubmit);
}

class _NewTodoState extends State<NewTodo> {
  _NewTodoState(this.onSubmit) : super();
  final _formKey = GlobalKey<FormState>();
  final onSubmit;
  final TextEditingController teCtrl = TextEditingController();

  addTodo() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      teCtrl.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: TextFormField(
                controller: teCtrl,
                decoration: InputDecoration(hintText: "Create a new Todo"),
                onEditingComplete: addTodo,
                onSaved: (val) {
                  onSubmit(val);
                  print("Saving: $val");
                },
                validator: (val) {
                  return val.trim().length < 1
                      ? "Can't add an empty todo"
                      : null;
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: RaisedButton(
                  color: Colors.lightGreen[500],
                  textColor: Colors.white,
                  onPressed: addTodo,
                  child: Text("Add"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
