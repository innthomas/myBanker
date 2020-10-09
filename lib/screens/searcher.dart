import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'buildShowDialog.dart';
import 'build_listview.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        title: buildTextField(),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
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
                              buildShowDialog(context);
                            },
                            child: buildListView(snapshot),
                          );
                      }
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  TextField buildTextField() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        labelText: "Search Account Name",
      ),
      onChanged: (value) {
        setState(() {
          searchString = value.toLowerCase();
        });
      },
    );
  }
}
