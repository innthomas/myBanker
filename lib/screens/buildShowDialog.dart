import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

Future buildShowDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text("Material Dialog"),
            content: Text("data"),
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
