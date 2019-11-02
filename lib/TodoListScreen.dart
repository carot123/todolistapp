import 'package:flutter/material.dart';
import 'package:todolistapp/TodoModel.dart';
import 'package:todolistapp/CreateOrUpdateScreen.dart';
import 'package:toast/toast.dart';

class TodoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TodoListListener();
  }
}

class TodoListListener extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new TodoListState();
  }
}

enum Answers{
  UPDATE,
  DELETE
}

class TodoListState extends State<TodoListListener> {
  List<TodoModel> todoListModel = new List();


  bool _isSearching = false;
  String _error;
  List<TodoModel> _results = List();

  @override
  void initState() {
    // TODO: implement initState
    initData();
    todoListModel = _results;
    super.initState();

  }



  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: TextField(
//          autofocus: true,
         //controller: searchQuery,
          onChanged: (text){
            setState(() {



                todoListModel=
                    _results.where((todoModel) => (todoModel.name
                        .toLowerCase()
                        .contains(text.toLowerCase())))
                        .toList();


          //    Toast.show(text, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            });
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                  padding: EdgeInsetsDirectional.only(end: 16.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
              hintText: "Search repositories...",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              clicked(context);
            },
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              switch(value){
                case 1:
                  showToast("Sort");
                  setState(() {
                    todoListModel.sort((a,b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
                  });

                  break;
              }
            },
            itemBuilder: (context){
              return [
                PopupMenuItem(
                    child: Text("Sort"),
                    value: 1,
                ),
              ];

            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[Expanded(child: listViewTodo(context))],
        ),
      ),
    );
  }

  Widget listViewTodo(BuildContext context) {
    return ListView.builder(
        itemCount: todoListModel.length,
        itemBuilder: (context, index) {
          var todoModel = todoListModel[index];
          return GestureDetector(
            onTap: (){

            },
            onLongPress: () {
            _askUser(todoModel, index);
            },
            child: itemTodo(todoModel),
          );
        });
  }


  Future _askUser(TodoModel todoModel, int index) async {
    await showDialog(
        context: context,
        builder: (context){
          return  SimpleDialog(
            children: <Widget>[
              new SimpleDialogOption(
                child: Text('Update'),
                onPressed: (){
                    update(context, todoModel, index);
                  },
              ),
              new SimpleDialogOption(child: Text('Delete'),
                    onPressed: (){
                      setState(() {
                        todoListModel.remove(todoModel);
                      });
                      Navigator.pop(context);

                },
              ),
            ],
          );
        },

    );

  }


  Widget itemTodo(TodoModel todoModel) {
    return Card(
      elevation: 3.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          textViewName(todoModel.name),
          textViewName(todoModel.time)
        ],
      ),
    );
  }

  Widget textViewName(String name) {
    return Text(name);
  }

  void initData() {
    _results.add(TodoModel("B", "abc", "jhhh"));
    _results.add(TodoModel("C", "abc", "jhhh"));
    _results.add(TodoModel("A", "abc", "jhhh"));
    _results.add(TodoModel("D", "abc", "jhhh"));
  }

  void clicked(BuildContext context) async {
    Route route = MaterialPageRoute(builder: (context) {
      return CreateOrUpdateScreen(1, null);
    });

    TodoModel todoModel = await Navigator.push(context, route) as TodoModel;
    todoListModel.add(todoModel);
  }

  void update(BuildContext context, TodoModel oldTodoModel, int index) async {
    Route route = MaterialPageRoute(builder: (context) {
      return CreateOrUpdateScreen(2,oldTodoModel);
    });

    TodoModel todoModel = await Navigator.push(context, route) as TodoModel;
    todoListModel[index].name = todoModel.name;
    showToast(todoModel.name);


//    if(todoListModel.indexOf(todoModel) > -1){
//      todoListModel[todoListModel.indexOf(todoModel)].name = todoModel.name;
//      todoListModel[todoListModel.indexOf(todoModel)].description = todoModel.description;
//      showToast(todoListModel[todoListModel.indexOf(todoModel)].name);
//    }

    Navigator.pop(context);
  }

  showToast(String name) {
    Toast.show(name, context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              " Edit",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}
