import 'package:vks/models/account.dart';
import 'package:vks/models/history_node.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/tag.dart';
import '../models/wallet.dart';

class DatabaseService {
  FirebaseDatabase db = FirebaseDatabase.instance;

  String? get uid => FirebaseAuth.instance.currentUser?.uid;
  DatabaseReference get userRef => db.ref('accounts/$uid');

  Stream<Account> getAccountStream() {
    return userRef.onValue.map((event) {
      return Account.fromDataSnapshot(event.snapshot);
    });
  }

  Stream<List<Tag>> getTagsStream() {
    return userRef.child('tags').onValue.map(
        (event) => event.snapshot.children.map(Tag.fromDataSnapshot).toList());
  }

  Future<void> addWallet(Wallet wallet) async {
    var walletRef = userRef.child('wallets').push();
    await walletRef.update((wallet..wid = walletRef.key!).toJson());
  }

  Future<void> addTag(Tag tag) async {
    userRef.child('tags/${tag.name}').update(tag.toJson());
  }

  Future<void> transaction(String walletId, HistoryNode historyNode) async {
    await userRef.child('wallets/$walletId').runTransaction((Object? wallet) {
      Map<String, dynamic> walMap = Map<String, dynamic>.from(wallet as Map);

      if (historyNode.action == WalletAction.gelir) {
        walMap['amount'] += historyNode.amount;
      } else {
        if (double.parse(walMap['amount'].toString()) < historyNode.amount) {
          throw Exception('too-much');
        }
        walMap['amount'] -= historyNode.amount;
      }

      walMap['last-updated'] = historyNode.date.millisecondsSinceEpoch;
      return Transaction.success(walMap);
    });

    await userRef
        .child('wallets/$walletId/history')
        .orderByChild('date')
        .ref
        .push()
        .update(historyNode.toJson());
  }

  void updateHistoryNodeDescription(
      String wid, String hid, String newDescription) {
    userRef.child('wallets/$wid/history/$hid/description').set(newDescription);
  }

  void updateWalletDescription(String wid, String newDescription) {
    userRef.child('wallets/$wid/description').set(newDescription);
  }

  Future<void> deleteTag(Tag tag) async {
    userRef.child('/tags/${tag.name}').remove();
  }

  void deleteWallet(String wid) {
    userRef.child('wallets/$wid').remove();
  }

  Future<void> deleteHistoryNode(String wid, HistoryNode historyNode) async {
    await userRef.child('wallets/$wid/history/${historyNode.hid}').remove();
  }

  Future<void> deleteAccount() async {
    userRef.remove();
  }
}
