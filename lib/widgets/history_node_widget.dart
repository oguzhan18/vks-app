import 'package:vks/functions.dart';
import 'package:vks/models/history_node.dart';
import 'package:vks/models/tag.dart';
import 'package:vks/pages/edit_history_node_dialog.dart';
import 'package:vks/services/database_service.dart';
import 'package:vks/widgets/tag_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../services/theme_service.dart';

class HistoryNodeWidget extends StatefulWidget {
  HistoryNodeWidget({
    Key? key,
    required this.historyNode,
    required this.tags,
    required this.wid,
    required this.weirdCallback,
  }) : super(key: key);

  /// wallet id
  String wid;
  HistoryNode historyNode;
  List<Tag> tags;
  Function() weirdCallback;

  @override
  State<HistoryNodeWidget> createState() => _HistoryNodeWidgetState();
}

class _HistoryNodeWidgetState extends State<HistoryNodeWidget> {
  late DatabaseService dbServ;

  bool isShowAllDescription = false;
  GlobalKey<PopupMenuButtonState> popupKey = GlobalKey<PopupMenuButtonState>();

  @override
  void initState() {
    super.initState();
    dbServ = context.read<DatabaseService>();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: ThemeService.defaultPadding,
        vertical: ThemeService.defaultPadding / 2,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
            // minHeight: 48,
            ),
        child: InkWell(
          borderRadius: BorderRadius.circular(ThemeService.defaultPadding),
          onLongPress: () {
            popupKey.currentState!.showButtonMenu();
          },
          onTap: () {
            setState(() {
              isShowAllDescription = !isShowAllDescription;
            });
          },
          child: PopupMenuButton<int>(
            key: popupKey,
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(value: 0, child: Text('Düzenle')),
                const PopupMenuItem<int>(value: 1, child: Text('Sil'))
              ];
            },
            enabled: false,
            tooltip: '',
            onSelected: (val) async {
              if (val == 0) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return EditDescriptionDialog(
                        hid: widget.historyNode.hid,
                        description: widget.historyNode.description,
                        wid: widget.wid,
                        editDescription: EditDescription.historyNode,
                      );
                    });
              } else if (val == 1) {
                bool? delete = await showYesNoDialog(
                  context: context,
                  message: 'Bu notu silmek istediğinizden emin misiniz?',
                );
                if (delete == true) {
                  dbServ.deleteHistoryNode(widget.wid, widget.historyNode);
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.historyNode.action == WalletAction.gelir ? '+' : '-'}${widget.historyNode.amount}',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    color: widget.historyNode.action ==
                                            WalletAction.gelir
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text(
                              DateFormat('dd.MM.yyyy, HH:mm')
                                  .format(widget.historyNode.date),
                              style: Theme.of(context).textTheme.bodyText1)
                        ]),
                    if (widget.historyNode.tagName.isNotEmpty) ...[
                      hgh(4),
                      TagWidget(
                        tag: widget.tags.firstWhere(
                            (e) => e.name == widget.historyNode.tagName,
                            orElse: () => Tag.initial(widget.historyNode.action)
                              ..name = widget.historyNode.tagName),
                      ),
                    ],
                    if (widget.historyNode.description.isNotEmpty) ...[
                      hgh(4),
                      Text(widget.historyNode.description,
                          overflow: isShowAllDescription
                              ? TextOverflow.clip
                              : TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText2)
                    ]
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
