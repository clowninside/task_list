import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

const STATE_TASK_DONE = "DONE";
const STATE_TASK_ACTIVE = "ACTIVE";

class Task {
  String state = STATE_TASK_ACTIVE;
  String userTodo = '';
  String userPrice = '';

  Task(this.userTodo, this.userPrice);
}

class _HomeState extends State<Home> {
  List<Task> todoList = [];

  @override
  Widget build(BuildContext context) {
    String _userTodo = '';
    String _userPrice = '';
    return Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        title: Text('Task List'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text('no tasks');
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(snapshot.data!.docs[index].id),
                  child: Card(
                    child: ListTile(
                      title: Text(snapshot.data!.docs[index].get('task') +
                          " " +
                          snapshot.data!.docs[index].get('price')),
                      trailing: IconButton(
                        icon: Icon(Icons.check,
                            color: todoList[index].state == STATE_TASK_DONE
                                ? Colors.green
                                : Colors.red),
                        onPressed: () {
                          setState(() {
                            if (todoList[index].state == STATE_TASK_DONE) {
                              todoList[index].state = STATE_TASK_ACTIVE;
                            } else {
                              todoList[index].state = STATE_TASK_DONE;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      FirebaseFirestore.instance
                          .collection('items')
                          .doc(snapshot.data!.docs[index].id)
                          .delete();
                    });
                  },
                );
              });
        },
      ),
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
                          FirebaseFirestore.instance
                              .collection('items')
                              .add({'task': _userTodo, 'price': _userPrice});
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
