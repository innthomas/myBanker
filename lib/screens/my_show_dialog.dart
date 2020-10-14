import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

TextEditingController amtController = TextEditingController();
Future myShowDialog(context, DocumentSnapshot document) {
  return showDialog(
    context: context,
    builder: (_) => new AlertDialog(
      title: Column(
        children: [
          new Text(
            document["acctName"],
            style: TextStyle(fontFamily: "Pacifico", fontSize: 25.0),
          ),
          Text(
            document["acctNumber"].toString(),
          ),
        ],
      ),
      content: new TextField(
        decoration: InputDecoration(
          labelText: "amount",
        ),
      ),
      actions: <Widget>[
        RaisedButton(
          color: Colors.red,
          child: Text('wDraw'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        RaisedButton(
          color: Colors.green,
          child: Text('Deposit'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        RaisedButton(
          color: Colors.amber,
          child: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
