import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  State<DoneScreen> createState() => _HomeState();
}

class _HomeState extends State<DoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        title: Text('Dones List'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('dones').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(snapshot.data!.docs[index].id),
                  child: Card(
                    child: ListTile(
                      title: Text(snapshot.data!.docs[index]
                              .get('task1')
                              .toString() +
                          " " +
                          snapshot.data!.docs[index].get('price1').toString()),
                    ),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      FirebaseFirestore.instance
                          .collection('dones')
                          .doc(snapshot.data!.docs[index].id)
                          .delete();
                    });
                  },
                );
              });
        },
      ),
    );
  }
}
