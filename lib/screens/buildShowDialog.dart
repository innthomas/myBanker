import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myBanker/provider/account_provider.dart';
import 'package:provider/provider.dart';
import '../models/account_model.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference users = firestore.collection("bankAccounts");
TextEditingController _amtController = TextEditingController();
Account accounts = Account();

Future buildShowDialog(BuildContext context) {
  final accounts = Provider.of<List<Account>>(context);
  final acctProvider = Provider.of<AccountProvider>(context, listen: false);
  acctProvider.loadValues(Account());

  return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text(acctProvider.acctName.toString()),
            content: TextField(
              decoration: InputDecoration(hintText: "amount"),
              controller: _amtController,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('deposit/withdraw !'),
                onPressed: () {
                  _updateData();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}

void _updateData() async {
  await users.doc().update({
    "acctDeposit": _amtController.text,
  });
  print(users.doc().snapshots());
}
