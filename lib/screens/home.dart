import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myBanker/screens/add_account.dart';
import 'package:myBanker/screens/my_drawer.dart';
import 'buildShowDialog.dart';
import 'build_listview.dart';

import '../screens/searcher.dart';

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
                MaterialPageRoute(builder: (context) => AddAccount()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          )
        ],
        toolbarHeight: 100.0,
        backgroundColor: Colors.teal[900],
        title: Center(
            child: Text(
          "ThriftApp",
          style: TextStyle(
            fontFamily: "FugazOne",
          ),
        )),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: (searchString == null || searchString.trim() == "")
                  ? FirebaseFirestore.instance
                      .collection("bankAccounts")
                      .orderBy("acctNumber")
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection("bankAccounts")
                      .orderBy("acctNumber")
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
                    return InkWell(
                      onTap: () {
                        setState(() {
                          buildShowDialog(context);
                        });
                      },
                      child: buildListView(snapshot),
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
