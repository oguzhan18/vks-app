// ignore_for_file: must_be_immutable

import 'package:vks/models/history_node.dart';
import 'package:vks/models/wallet.dart';
import 'package:vks/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/account.dart';
import '../widgets/history_node_widget.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key, required this.walletId}) : super(key: key);

  String walletId;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late DatabaseService dbServ;
  late Stream<Account> accountStream;

  @override
  void initState() {
    super.initState();
    dbServ = context.read<DatabaseService>();
    accountStream = dbServ.getAccountStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Account>(
        stream: accountStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Account account = snapshot.data!;
            Wallet curWallet =
                account.wallets.firstWhere((w) => w.wid == widget.walletId);
            return Scaffold(
              appBar: AppBar(
                  title: Text(curWallet.description.replaceAll('\n', ' '))),
              body: ListView(children: [
                for (HistoryNode hn in curWallet.history)
                  HistoryNodeWidget(
                      historyNode: hn,
                      tags: account.tags,
                      wid: curWallet.wid,
                      weirdCallback: () {})
              ]),
            );
          }
          return buildLoading();
        });
  }

  Widget buildLoading() {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Wallet'),
        ),
        body: const Center(child: CircularProgressIndicator()));
  }
}
