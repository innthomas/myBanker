import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddAccount extends StatefulWidget {
  @override
  _AddAccountState createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
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
        title: Text(
          "add new account",
          style: TextStyle(fontFamily: "FugazOne"),
        ),
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
