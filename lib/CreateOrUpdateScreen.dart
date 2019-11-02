import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todolistapp/TodoModel.dart';
import 'package:toast/toast.dart';

class CreateOrUpdateScreen extends StatelessWidget{

  final int status;
  TodoModel oldTodoModel;

  CreateOrUpdateScreen(this.status, this.oldTodoModel);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(status == 1) {
      return CreateOrUpdateScreenListener(status, null);
    }else{
      return CreateOrUpdateScreenListener(status, oldTodoModel);
    }
  }

}

class CreateOrUpdateScreenListener extends  StatefulWidget{
  int status;
  TodoModel _model;
  CreateOrUpdateScreenListener(this.status, this._model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    if(status == 1) {
      return CreateOrUpdateState("Insert", null, status);
    }else{
      return CreateOrUpdateState("Update", _model, status);
    }
  }

}

class CreateOrUpdateState extends State<CreateOrUpdateScreenListener>{
  String title;
  int status;
  TodoModel oldTodoModel;
  CreateOrUpdateState(this.title, this.oldTodoModel, this.status);
  TodoModel todoModel;
  final txtName = TextEditingController();
  final txtDescription = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    if(status == 2){
      txtDescription.text = oldTodoModel.description;
      txtName.text = oldTodoModel.name;

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: (){
              saveTodo(context);
            },
          )
        ],
        leading: IconButton(
          icon:Icon(Icons.arrow_back),
          onPressed:() {
            Navigator.pop(context, todoModel);
           // showToast();
          },
        ),
    ),

      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: 'name'
                ),
                controller: txtName,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'description'
                ),
                controller: txtDescription,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveTodo(BuildContext context) {
    todoModel = TodoModel(txtName.text, txtDescription.text,"");
    Toast.show(todoModel.name, context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  showToast() {
    Toast.show("hello", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

}