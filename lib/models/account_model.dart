class Account {
  final String acctName;
  num acctNumber;
  final double acctBalance;
  final String id;
  final DateTime date;

  Account({
    this.acctName,
    this.acctNumber,
    this.acctBalance,
    this.id,
    this.date,
  });

  Account.fromMap(Map<String, dynamic> data, String id, double acctBalance,
      String uuid, DateTime date, String acctName)
      : acctName = data["acctName"],
        acctNumber = data['acctNumber'],
        acctBalance = data["acctBalance"],
        date = data["date"],
        id = id;

  Map<String, dynamic> toMap() {
    return {
      "acctName": acctName,
      "acctNumber": acctNumber,
      "acctBalance": acctBalance,
      "date": date,
    };
  }

  Account.fromFirestore(Map<String, dynamic> firestore, this.id)
      : acctNumber = firestore['acctNumber'],
        date = firestore["date"],
        acctName = firestore['acctName'],
        acctBalance = firestore['acctBalance'];
}
