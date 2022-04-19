import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _userTodo = '';
  String _userPrice = '';
  List todoList = [];
  Color _BasedColor = Colors.red;

  @override
  void initState() {
    super.initState();

    todoList.addAll(['buy milk', 'suck cock']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        title: Text('Task List'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(todoList[index]),
              child: Card(
                child: ListTile(
                  title: Text(todoList[index]),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.check,
                      color: _BasedColor,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_BasedColor == Colors.red) {
                          _BasedColor = Colors.green;
                        } else {
                          _BasedColor = Colors.red;
                        }
                      });
                    },
                  ),
                ),
              ),
              onDismissed: (direction) {
                setState(() {
                  todoList.removeAt(index);
                });
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Add New Task'),
                  content: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Task Name",
                            fillColor: Colors.black12,
                            filled: true),
                        onChanged: (String value) {
                          _userTodo = value;
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Task Price",
                            fillColor: Colors.black12,
                            filled: true),
                        onChanged: (String value) {
                          _userPrice = value;
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            todoList.add(_userTodo);
                            //todoList.add(_userPrice);
                          });

                          Navigator.of(context).pop();
                        },
                        child: Text('Add'))
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
