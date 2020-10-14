import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myBanker/models/account_model.dart';
import 'package:provider/provider.dart';
import '../services/firestore_service.dart';

import 'package:flutter/material.dart';

class UpdatePage extends StatefulWidget {
  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  Widget build(BuildContext context) {
    final accounts = Provider.of<List<Account>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
    );
  }
}
