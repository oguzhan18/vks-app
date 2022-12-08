import 'package:vks/ad_options.dart';
import 'package:vks/functions.dart';
import 'package:vks/models/history_node.dart';
import 'package:vks/models/tag.dart';
import 'package:vks/pages/tags_dialog.dart';
import 'package:vks/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../models/wallet.dart';
import '../widgets/tag_widget.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({
    Key? key,
    required this.action,
    required this.wallet,
  }) : super(key: key);

  final WalletAction action;
  final Wallet wallet;

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late DatabaseService dbServ;
  late HistoryNode historyNode;

  InterstitialAd? intAd;
  late BannerAd banAd;

  GlobalKey<FormFieldState> amountKey = GlobalKey<FormFieldState>();
  late Tag curTag;
  TextEditingController amountCont = TextEditingController();
  String get walletId => widget.wallet.wid;

  @override
  void initState() {
    super.initState();
    dbServ = context.read<DatabaseService>();
    historyNode = HistoryNode.empty(widget.action);
    curTag = Tag.initial(widget.action)
      ..name = 'Kategori Seçin Yada Ekleyiniz.. ';
    loadIntAd();
    loadBanAd();
  }

  loadIntAd() {
    InterstitialAd.load(
        adUnitId: AdDefaultOptions.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {});
            intAd = ad;
          },
          onAdFailedToLoad: (err) {},
        ));
  }

  loadBanAd() {
    banAd = BannerAd(
      adUnitId: AdDefaultOptions.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {});
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    );
    banAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          // title: Text(widget.action.name.toUpperCase()),
          title: Text(widget.action.name.toUpperCase()),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (banAd.responseInfo != null)
                    SizedBox(
                      height: 50,
                      child: AdWidget(ad: banAd),
                    ),
                  hgh(8),
                  InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: () async {
                      Tag? tag = await showDialog(
                        context: context,
                        builder: (_) => TagsDialog(action: widget.action),
                      );
                      if (tag != null) {
                        setState(() {
                          historyNode.tagName = tag.name;
                          curTag = tag;
                        });
                      }
                    },
                    child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4)),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        alignment: Alignment.centerLeft,
                        child: TagWidget(tag: curTag)),
                  ),
                  hgh(8),
                  TextFormField(
                    key: amountKey,
                    controller: amountCont,
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      historyNode.amount = double.parse(v.replaceAll(',', '.'));
                    },
                    validator: (v) {
                      double val = double.parse(v!.isEmpty ? '0' : v);
                      if (val <= 0) {
                        return 'Lütfen miktar giriniz...';
                      } else if (widget.action == WalletAction.gider &&
                          val > widget.wallet.amount) {
                        return 'Çok fazla girilen miktar. Mevcut: ${widget.wallet.amount} ${widget.wallet.currency}.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Miktar'),
                  ),
                  hgh(8),
                  SizedBox(
                    height: 200,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.top,
                      maxLength: 255,
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Açıklama',
                        alignLabelWithHint: true,
                      ),
                      onChanged: (v) {
                        historyNode.description = v;
                      },
                    ),
                  ),
                  ElevatedButton(
                    child: Text(widget.action.name.toUpperCase()),
                    onPressed: () async {
                      if (amountKey.currentState!.validate()) {
                        await dbServ.transaction(walletId, historyNode);
                        if (mounted) Navigator.pop(context);
                        intAd?.show().then((v) => intAd?.dispose());
                      }
                    },
                  ),
                ]),
          ),
        ));
  }
}
