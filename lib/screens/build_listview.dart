import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'my_show_dialog.dart';

ListView buildListView(AsyncSnapshot<QuerySnapshot> snapshot, context) {
  return ListView(
    padding: EdgeInsets.all(10.0),
    shrinkWrap: true,
    children: snapshot.data.docs.map((DocumentSnapshot document) {
      return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 25.0,
        shadowColor: Colors.greenAccent,
        child: InkWell(
          onTap: () {
            print(document["acctName"]);
            myShowDialog(context, document);
          },
          child: ListTile(
            tileColor: Colors.white10,
            leading: Icon(
              Icons.person,
              color: Colors.teal[800],
            ),
            title: Text(
              document["acctName"],
              style: TextStyle(fontFamily: "FugazOne"),
            ),
            subtitle: Text(
              document["acctNumber"].toString(),
              style: TextStyle(
                  color: Colors.brown[800],
                  fontSize: 15.0,
                  fontWeight: FontWeight.w800),
            ),
            trailing: Text(
              document["acctDeposit"].toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20.0,
                  color: (document["acctDeposit"] < 0
                      ? Colors.red
                      : Colors.green[800])),
            ),
          ),
        ),
      );
    }).toList(),
  );
}
