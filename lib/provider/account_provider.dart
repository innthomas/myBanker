import 'package:flutter/material.dart';
import 'package:myBanker/models/account_model.dart';
import 'package:myBanker/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class AccountProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _acctName;
  double _acctBalance;
  double _acctNumber;
  DateTime _date;
  var uuid = Uuid();

  //Getters
  String get acctName => _acctName;
  double get acctBalance => _acctBalance;

  //Setters
  changeacctName(String value) {
    _acctName = value;
    notifyListeners();
  }

  changeacctBalance(String value) {
    _acctBalance = double.parse(value);
    notifyListeners();
  }

  loadValues(Account account) {
    _acctName = account.acctName;
    _acctBalance = account.acctBalance;
    _acctNumber = account.acctNumber;
    _date = account.date;
  }

  addAccount() {
    print(_acctNumber);
    if (_acctNumber == null) {
      var newAccount = Account(
        acctName: acctName,
        acctBalance: acctBalance,
        acctNumber: _acctNumber,
        date: _date,
      );
      firestoreService.addAccount(newAccount);
    } else {
      //Update
      var updatedAccount = Account(
          acctName: acctName,
          acctBalance: _acctBalance,
          acctNumber: _acctNumber);
      firestoreService.addAccount(updatedAccount);
    }
  }

  deleteAccount(String acctNumber) {
    firestoreService.deleteAccount(acctNumber);
  }
}
