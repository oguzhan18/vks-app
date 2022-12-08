import 'package:vks/models/history_node.dart';
import 'package:vks/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum EditDescription { historyNode, wallet }

class EditDescriptionDialog extends StatefulWidget {
  const EditDescriptionDialog({
    Key? key,
    this.wid,
    this.hid,
    required this.description,
    required this.editDescription,
  })  : assert(
            wid != null &&
                (editDescription == EditDescription.historyNode &&
                        hid != null ||
                    editDescription == EditDescription.wallet),
            'pass wallet id and history node id when editing historyNode\'s description'),
        super(key: key);

  /// wallet id
  final String? wid;
  final String? hid;
  final String description;
  final EditDescription editDescription;

  @override
  State<EditDescriptionDialog> createState() => _EditDescriptionDialogState();
}

class _EditDescriptionDialogState extends State<EditDescriptionDialog> {
  late DatabaseService dbServ;
  TextEditingController descrCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbServ = context.read<DatabaseService>();
    descrCont.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: const EdgeInsets.all(20),
        content: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 280),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 200,
                  child: TextFormField(
                    controller: descrCont,
                    textAlignVertical: TextAlignVertical.top,
                    maxLength: 255,
                    expands: true,
                    maxLines: null,
                    minLines: null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                ElevatedButton(
                  child: const Text('save'),
                  onPressed: () {
                    if (widget.editDescription == EditDescription.historyNode) {
                      dbServ.updateHistoryNodeDescription(
                          widget.wid!, widget.hid!, descrCont.text);
                    } else {
                      dbServ.updateWalletDescription(
                          widget.wid!, descrCont.text);
                    }
                    Navigator.pop(context);
                  },
                )
              ]),
        ));
  }
}
