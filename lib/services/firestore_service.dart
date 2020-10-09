import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myBanker/models/account_model.dart';

class FirestoreService {
  static final FirestoreService _firestoreService =
      FirestoreService._internal();
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirestoreService._internal();
  factory FirestoreService() {
    return _firestoreService;
  }
  Stream<List<Account>> getAccounts() {
    Account acct = Account();
    return _db.collection('bankAccounts').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => Account.fromMap(
                    doc.data(),
                    acct.id,
                    acct.acctBalance,
                    acct.date,
                    acct.acctName,
                  ))
              .toList(),
        );
  }

  Future<void> addAccount(Account account) {
    return _db.collection('bankAccounts').add(account.toMap());
  }

  Future<void> deleteAccount(String id) {
    return _db.collection('bankAccounts').doc(id).delete();
  }

  Future<void> updateAccount(Account account) {
    return _db
        .collection('bankAccounts')
        .doc(account.id)
        .update((account.toMap()));
  }
}
