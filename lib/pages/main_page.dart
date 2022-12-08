import 'dart:io';

import 'package:vks/ad_options.dart';
import 'package:vks/constants.dart';
import 'package:vks/models/account.dart';
import 'package:vks/pages/history_page.dart';
import 'package:vks/pages/login_page.dart';
import 'package:vks/pages/settings_page.dart';
import 'package:vks/pages/transaction_page.dart';
import 'package:vks/services/auth_service.dart';
import 'package:vks/services/database_service.dart';
import 'package:vks/services/theme_service.dart';
import 'package:vks/widgets/history_node_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../functions.dart';
import '../models/history_node.dart';
import '../models/wallet.dart';
import '../widgets/current_wallet.dart';
import '../widgets/wallet_widget.dart';
import 'add_wallet_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late AuthService authServ;
  late DatabaseService dbServ;
  late ThemeService themeServ;
  late Stream<Account> accountStream;
  late Account account;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Wallet? curWallet;
  bool isBottomSheetOpened = false;

  @override
  void initState() {
    super.initState();
    authServ = context.read<AuthService>();
    themeServ = context.read<ThemeService>();
    dbServ = context.read<DatabaseService>();
    accountStream = dbServ.getAccountStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
          title: const Text('Expenses History App'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
            )
          ]),
      body: StreamBuilder<Account>(
          stream: accountStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              account = snapshot.data!;
              configureCurWallet(account);
              return buildWallets();
            }
            return const Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
          tooltip: 'GİDER EKLE',
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddWalletPage(),
              ),
            );
          }),
    );
  }

  Widget buildWallets() {
    return Padding(
      padding: const EdgeInsets.only(
        left: ThemeService.defaultPadding,
      ),
      child: SingleChildScrollView(
        child: ResponsiveGridRow(
          children: [
            ...account.wallets.map((w) => ResponsiveGridCol(
                  xs: 6,
                  sm: 4,
                  md: 4,
                  lg: 2,
                  xl: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: ThemeService.defaultPadding,
                        right: ThemeService.defaultPadding),
                    child: WalletWidget(
                      wallet: w,
                      onDelete: () async {
                        bool? delete = await showYesNoDialog(
                            context: context,
                            message:
                                'Bu gideri silmek istediğinize emin misiniz?');
                        if (delete == true) {
                          dbServ.deleteWallet(w.wid);
                        }
                      },
                      onTap: () {
                        setState(() {
                          curWallet = w;
                        });
                      },
                      onHistoryButton: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => HistoryPage(walletId: w.wid)));
                      },
                      isSelected: curWallet!.wid == w.wid,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void configureCurWallet(Account account) {
    if (curWallet == null && account.wallets.isNotEmpty) {
      curWallet = account.wallets[0];
    } else if (curWallet != null) {
      try {
        curWallet = account.wallets.firstWhere((w) => w.wid == curWallet!.wid);
      } catch (e) {
        curWallet = account.wallets.isNotEmpty ? account.wallets[0] : null;
      }
    }
  }
}
