import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TabTow extends StatefulWidget {
  const TabTow({Key? key}) : super(key: key);

  @override
  _TabTowState createState() => _TabTowState();
}

class _TabTowState extends State<TabTow> {
  late String productName, productImage, productPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Text("There are no products yet!!");
            } else {
              return GridView.count(
                crossAxisCount: 2,
                children: List.generate(snapshot.data!.docs.length, (index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    margin: const EdgeInsets.all(10.0),
                    // color: Colors.yellow,
                    elevation: 30.0,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              snapshot.data!.docs[index].get('ProductImage'),
                            ),
                            backgroundColor: Colors.red.shade800,
                            radius: 70,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            snapshot.data!.docs[index].get('ProductPrice'),
                            style: const TextStyle(
                              fontSize: 15.0,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            snapshot.data!.docs[index].get('ProductName'),
                            style: const TextStyle(
                              fontSize: 15.0,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              );
            }
          }),
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
                        decoration:
                            const InputDecoration(hintText: "Product Name"),
                        onChanged: (String value) {
                          productName = value;
                        },
                      ),
                      TextField(
                          decoration: const InputDecoration(
                              hintText: "Product Image URL"),
                          onChanged: (String contact) {
                            productImage = contact;
                          }),
                      TextField(
                          decoration:
                              const InputDecoration(hintText: "Product Price"),
                          onChanged: (String price) {
                            productPrice = price;
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
                      FirebaseFirestore.instance.collection('products').add({
                        'ProductName': productName,
                        'ProductImage': productImage,
                        'ProductPrice': productPrice
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text("Add New Product"),
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
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
