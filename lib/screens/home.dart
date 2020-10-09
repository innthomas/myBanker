import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myBanker/screens/my_drawer.dart';

import '../searcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String searchString = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        elevation: 29.0,
        shadowColor: Colors.blueGrey,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
        toolbarHeight: 100.0,
        backgroundColor: Colors.teal[900],
        title: Center(
            child: Text(
          "ThriftApp",
          style: TextStyle(fontFamily: "FugazOne"),
        )),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: (searchString == null || searchString.trim() == "")
                  ? FirebaseFirestore.instance
                      .collection("bankAccounts")
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection("bankAccounts")
                      .where(
                        "searchIndex",
                        arrayContains: searchString,
                      )
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return Text("Error:${snapshot.hasError}");
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    return ListView(
                      padding: EdgeInsets.all(10.0),
                      shrinkWrap: true,
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          elevation: 25.0,
                          shadowColor: Colors.greenAccent,
                          child: ListTile(
                            tileColor: Colors.white10,
                            leading: Icon(
                              Icons.person,
                              color: Colors.teal[800],
                            ),
                            title: Text(document["acctName"]),
                            subtitle: Text(
                              document["acctNumber"].toString(),
                              style: TextStyle(
                                  color: Colors.brown[800],
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w800),
                            ),
                            trailing: Text(
                              document["acctDeposit"].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20.0,
                                  color: (document["acctDeposit"] < 0
                                      ? Colors.red
                                      : Colors.green[800])),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
