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
                child: Text('Close me!'),
                onPressed: () {
                  _updateData();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}

void _updateData() async {
  users
      .doc("acctNumber")
      .update({"acctDeposit": double.parse(_amtController.text)});
}
