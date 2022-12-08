import 'package:firebase_database/firebase_database.dart';

enum WalletAction { gelir, gider }

class HistoryNode {
  String hid;
  DateTime date;
  double amount;
  WalletAction action;
  String description;
  String tagName;

  HistoryNode(
      {required this.hid,
      required this.date,
      required this.amount,
      required this.action,
      required this.description,
      required this.tagName});

  factory HistoryNode.fromDataSnapshot(DataSnapshot snapshot) {
    return HistoryNode(
        hid: snapshot.key!,
        date: DateTime.fromMillisecondsSinceEpoch(
            snapshot.child('date').value as int),
        amount: double.parse(snapshot.child('amount').value.toString()),
        action: snapshot.child('action').value as String == 'gider'
            ? WalletAction.gider
            : WalletAction.gelir,
        description: snapshot.child('description').value as String,
        tagName: snapshot.child('tag-name').value as String);
  }

  factory HistoryNode.empty(WalletAction action) {
    return HistoryNode(
        hid: '',
        date: DateTime.now(),
        amount: 0,
        action: action,
        description: '',
        tagName: '');
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.millisecondsSinceEpoch,
      'amount': amount,
      'action': action.name,
      'description': description.trim(),
      'tag-name': tagName
    };
  }
}
