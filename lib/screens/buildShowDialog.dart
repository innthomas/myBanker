import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference users = firestore.collection("bankAccounts");
TextEditingController _amtController = TextEditingController();

Future buildShowDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text("Material Dialog"),
            content: TextField(
              decoration: InputDecoration(hintText: "amount"),
              controller: _amtController,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('update me!'),
                onPressed: () {
                  _updateData();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}

void _updateData() async {
  await users.doc().update({"acctDeposit": 4000});
  print(users.doc().snapshots());
}
