import 'package:vks/functions.dart';
import 'package:vks/models/wallet.dart';
import 'package:vks/services/theme_service.dart';
import 'package:vks/widgets/wallet_action_button.dart';
import 'package:flutter/material.dart';

import '../models/history_node.dart';
import '../pages/edit_history_node_dialog.dart';
import '../pages/transaction_page.dart';

class WalletWidget extends StatefulWidget {
  const WalletWidget({
    Key? key,
    required this.wallet,
    required this.onTap,
    this.onDelete,
    required this.isSelected,
    required this.onHistoryButton,
  }) : super(key: key);

  final Wallet wallet;
  final void Function() onTap;
  final void Function()? onDelete;
  final void Function() onHistoryButton;
  final bool isSelected;

  @override
  State<WalletWidget> createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
  GlobalKey<PopupMenuButtonState> popupKey = GlobalKey<PopupMenuButtonState>();

  double? curHeight;
  GlobalKey contKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context);
    return PopupMenuButton<int>(
      key: popupKey,
      tooltip: '',
      enabled: false,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context) {
        return [
          const PopupMenuItem(value: 0, child: Text('Düzenle')),
          const PopupMenuItem(value: 1, child: Text('Sil'))
        ];
      },
      onSelected: (val) {
        if (val == 0) {
          showDialog(
              context: context,
              builder: (context) {
                return EditDescriptionDialog(
                  description: widget.wallet.description,
                  wid: widget.wallet.wid,
                  editDescription: EditDescription.wallet,
                );
              });
        } else if (val == 1) {
          if (widget.onDelete != null) widget.onDelete!();
        }
      },
      child: Card(
        margin: const EdgeInsets.all(0),
        // color: t.colorScheme.primary,
        child: InkWell(
          borderRadius: BorderRadius.circular(ThemeService.defaultPadding),
          onTap: () {
            widget.onTap();
          },
          onLongPress: () {
            popupKey.currentState!.showButtonMenu();
          },
          child: Padding(
            padding: const EdgeInsets.all(ThemeService.defaultPadding),
            child: AnimatedSize(
              curve: Curves.fastOutSlowIn,
              alignment: Alignment.topCenter,
              duration: const Duration(milliseconds: 300),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '${widget.wallet.amount} ${widget.wallet.currency}',
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      // color: Theme.of(context).colorScheme.onPrimary
                                    )),
                        if (widget.isSelected &&
                            widget.wallet.history.isNotEmpty)
                          InkWell(
                              onTap: widget.onHistoryButton,
                              borderRadius: BorderRadius.circular(10),
                              child: const Icon(Icons.history))
                      ],
                    ),
                    if (widget.wallet.description.isNotEmpty)
                      Text(
                        widget.wallet.description,
                        overflow: widget.isSelected
                            ? TextOverflow.clip
                            : TextOverflow.ellipsis,
                      ),
                    if (widget.isSelected) ...[
                      hgh(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildActionButton(context, onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => TransactionPage(
                                        action: WalletAction.gelir,
                                        wallet: widget.wallet)));
                          }, text: ' GELİR EKLE '),
                          wdt(ThemeService.defaultPadding),
                          buildActionButton(context, onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => TransactionPage(
                                        action: WalletAction.gider,
                                        wallet: widget.wallet)));
                          }, text: ' GİDER EKLE '),
                        ],
                      )
                    ]
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildActionButton(BuildContext context,
      {required onPressed, required text}) {
    var t = Theme.of(context);
    return Expanded(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 20,
          maxHeight: 20,
        ),
        child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(ThemeService.defaultPadding),
            color: t.colorScheme.primary,
            child: InkWell(
                borderRadius:
                    BorderRadius.circular(ThemeService.defaultPadding),
                onTap: onPressed,
                child: Center(
                  child: Text(text,
                      style: TextStyle(
                          color: t.buttonTheme.colorScheme?.onPrimary)),
                ))),
      ),
    );
  }
}
