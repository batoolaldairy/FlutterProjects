import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TabOne extends StatefulWidget {
  const TabOne({Key? key}) : super(key: key);

  @override
  _TabOneState createState() => _TabOneState();
}

class _TabOneState extends State<TabOne> {
  late String contactName = '';
  late String contact = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('contacts').snapshots(),
        builder: (BuildContext contact, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text('No Contacts in your List !!!!');
          return GridView.count(
            crossAxisCount: 3,
            children: List.generate(
              snapshot.data!.docs.length,
              (index) {
                return Card(
                  color: Colors.yellow[400],
                  elevation: 50.0,
                  margin: const EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  snapshot.data!.docs[index].get('name'),
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ]),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.data!.docs[index].get('contact'),
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0, right: 0.0),
                          child: IconButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('contacts')
                                  .doc(snapshot.data!.docs[index].id)
                                  .delete();
                            },
                            icon: const Icon(Icons.delete),
                            color: Colors.red[600],
                          ),
                        )
                      ]),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Add new Product"),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      TextField(
                        decoration: const InputDecoration(hintText: "Name"),
                        onChanged: (String value) {
                          contactName = value;
                        },
                      ),
                      TextField(
                          decoration:
                              const InputDecoration(hintText: "Contact"),
                          onChanged: (String Contact) {
                            contact = Contact;
                          }),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green[600],
                    ),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('contacts')
                          .add({'name': contactName, 'contact': contact});
                      Navigator.of(context).pop();
                    },
                    child: const Text("Add New Contact"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[600],
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue[700],
      ),
    );
  }
}

class ElvatedButton {}
