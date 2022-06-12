import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        title: const Text('Task List'),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/dones');
              },
              child: const Icon(Icons.check_box),
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(snapshot.data!.docs[index].id),
                  child: Card(
                    child: ListTile(
                      title: Text("${snapshot.data!.docs[index]
                              .get('task')} ${snapshot.data!.docs[index].get('price')}",),
                    ),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      FirebaseFirestore.instance
                          .collection('dones')
                          .doc(snapshot.data!.docs[index].id)
                          .set({
                        'task1':
                            snapshot.data!.docs[index].get('task').toString(),
                        'price1':
                            snapshot.data!.docs[index].get('price').toString()
                      });
                      FirebaseFirestore.instance
                          .collection('items')
                          .doc(snapshot.data!.docs[index].id)
                          .delete();
                    });
                  },
                );
              },);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          String _userTodo = '';
          String _userPrice = '';
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Add New Task'),
                  content: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Task Name",
                            fillColor: Colors.black12,
                            filled: true,),
                        onChanged: (String value) {
                          _userTodo = value;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Task Price",
                            fillColor: Colors.black12,
                            filled: true,),
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
                          FirebaseFirestore.instance.collection('items').add({
                            'task': _userTodo,
                            'price': _userPrice,
                            'isDone': false
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text('Add'),)
                  ],
                );
              },);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
