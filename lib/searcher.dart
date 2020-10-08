import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _addNameController = TextEditingController();
  TextEditingController _addAcctNumberController = TextEditingController();
  TextEditingController _addDepositController = TextEditingController();
  String searchString = "";
  @override
  void initState() {
    _addNameController = TextEditingController();
    _addAcctNumberController = TextEditingController();
    _addDepositController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add new account"),
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Account Name"),
                controller: _addNameController,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Account Number"),
                controller: _addAcctNumberController,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Deposit"),
                controller: _addDepositController,
              ),
              RaisedButton(
                color: Colors.teal[900],
                child: Text("add account"),
                textColor: Colors.white,
                onPressed: () {
                  _addToDatabase(
                    _addNameController.text,
                    int.parse(_addAcctNumberController.text),
                    double.parse(_addDepositController.text),
                  );
                  _addNameController.clear();
                  _addAcctNumberController.clear();
                  _addDepositController.clear();
                  Navigator.pop(context);
                },
              )
            ],
          ),
          Divider(),
          Expanded(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      labelText: "Search Account Name",
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchString = value.toLowerCase();
                      });
                    },
                  ),
                ),
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
                            children: snapshot.data.docs
                                .map((DocumentSnapshot document) {
                              return ListTile(
                                title: Text(document["acctName"]),
                                subtitle:
                                    Text(document["acctNumber"].toString()),
                                trailing:
                                    Text(document["acctDeposit"].toString()),
                              );
                            }).toList(),
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

  void _addToDatabase(String acctName, int acctNumber, double acctDeposit) {
    List<String> splitList = acctName.split(" ");
    List<String> indexList = [];
    for (int i = 0; i < splitList.length; i++) {
      for (int y = 1; y < splitList[i].length; y++) {
        indexList.add(
          splitList[i].substring(0, y).toLowerCase(),
        );
      }
    }
    print(indexList);
    FirebaseFirestore.instance.collection("bankAccounts").doc().set(
      {
        "acctName": acctName,
        "acctNumber": acctNumber,
        "acctDeposit": acctDeposit,
        "searchIndex": indexList,
      },
    );
  }
}
