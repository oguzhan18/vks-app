import 'package:vks/models/history_node.dart';
import 'package:vks/my_flutter_app_icons.dart';
import 'package:vks/pages/transaction_page.dart';
import 'package:vks/services/database_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../ad_options.dart';
import '../constants.dart';
import '../functions.dart';
import '../models/account.dart';
import '../models/wallet.dart';

class CurrentWallet extends StatefulWidget {
  const CurrentWallet(
      {Key? key, required this.curWallet, required this.account})
      : super(key: key);

  final Wallet? curWallet;
  final Account account;

  @override
  State<CurrentWallet> createState() => _CurrentWalletState();
}

class _CurrentWalletState extends State<CurrentWallet> {
  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(children: [
        Expanded(
            child: Center(
                child: RichText(
                    text: TextSpan(
                        text:
                            '${widget.curWallet?.amount.toStringAsFixed(2) ?? '00.00'} ',
                        style: t.textTheme.headline2!.copyWith(fontWeight: FontWeight.bold),
                        children: [
              TextSpan(
                  text: widget.curWallet?.currency ?? "",
                  style: t.textTheme.headline3)
            ])))),
        hgh(defaultPadding),
      ]),
    );
  }
}
