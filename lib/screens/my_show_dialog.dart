import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future myShowDialog(context, DocumentSnapshot document) {
  return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text(document["acctName"]),
            content: new Text("Hey! I'm Coflutter!"),
            actions: <Widget>[
              FlatButton(
                child: Text('Close me!'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}
