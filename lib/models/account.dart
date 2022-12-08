import 'package:vks/models/tag.dart';
import 'package:vks/models/wallet.dart';
import 'package:firebase_database/firebase_database.dart';

class Account {
  List<Tag> tags;
  List<Wallet> wallets;

  Account({required this.tags, required this.wallets});

  factory Account.empty() {
    return Account(tags: [], wallets: []);
  }

  factory Account.fromDataSnapshot(DataSnapshot snapshot) {
    return Account(
        wallets: snapshot.hasChild('wallets')
            ? () {
                List<Wallet> wallets = snapshot
                    .child('wallets')
                    .children
                    .map((ws) => Wallet.fromDataSnapshot(ws))
                    .toList();
                wallets.sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));
                return wallets;
              }()
            : [],
        tags: snapshot.hasChild('tags')
            ? snapshot
                .child('tags')
                .children
                .map((ws) => Tag.fromDataSnapshot(ws))
                .toList()
            : []);
  }
}
