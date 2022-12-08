// ignore_for_file: must_be_immutable

import 'package:vks/functions.dart';
import 'package:vks/models/history_node.dart';
import 'package:vks/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tag.dart';
import '../widgets/tag_widget.dart';

class TagsDialog extends StatefulWidget {
  TagsDialog({Key? key, required this.action}) : super(key: key);

  WalletAction action;

  @override
  State<TagsDialog> createState() => _TagsDialogState();
}

class _TagsDialogState extends State<TagsDialog> {
  late DatabaseService dbServ;
  late Stream<List<Tag>> tagsStream;

  TextEditingController cont = TextEditingController();
  GlobalKey<FormFieldState> fieldKey = GlobalKey<FormFieldState>();
  late Tag tagToAdd;
  bool isAddTag = false;
  List<Color> colors = [];

  @override
  void initState() {
    super.initState();
    dbServ = context.read<DatabaseService>();
    tagsStream = dbServ.getTagsStream();
    tagToAdd = Tag.initial(widget.action);
    colors.addAll(Colors.accents);
    colors.add(Colors.grey);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: SizedBox(
            height: 400,
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<List<Tag>>(
                  stream: tagsStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView(children: [
                        isAddTag
                            ? ListTile(
                                leading: const Icon(Icons.add),
                                title: const Text('Kategoriyi Ekle'),
                                onTap: () {
                                  setState(() {
                                    isAddTag = !isAddTag;
                                  });
                                },
                              )
                            : ListTile(
                                title: TextFormField(
                                  key: fieldKey,
                                  controller: cont,
                                  maxLength: 15,
                                  onChanged: (val) =>
                                      setState(() => tagToAdd.name = val),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Kategori adını giriniz...';
                                    } else if (snapshot.data!
                                        .map((e) => e.name)
                                        .contains(val)) {
                                      return '"$val" zaten var. Lütfen Farklı giriniz...';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      hintText:
                                          'Yeni bir kategori için yazın...'),
                                ),
                              ),
                        if (tagToAdd.name.isNotEmpty)
                          ListTile(
                              trailing: IconButton(
                                  icon: const Icon(Icons.check),
                                  onPressed: () {
                                    if (fieldKey.currentState!.validate()) {
                                      dbServ.addTag(tagToAdd);
                                    }
                                    tagToAdd = Tag.initial(widget.action);
                                    cont.clear();
                                  }),
                              title: DropdownButton<Color>(
                                value: tagToAdd.color,
                                isExpanded: true,
                                items: colors
                                    .map((e) => DropdownMenuItem<Color>(
                                        value: e,
                                        child: TagWidget(
                                            tag: Tag(
                                                color: e,
                                                name: tagToAdd.name,
                                                action: widget.action))))
                                    .toSet()
                                    .toList(),
                                onChanged: (v) {
                                  setState(() {
                                    tagToAdd.color = v!;
                                  });
                                },
                              )),
                        for (Tag tag in snapshot.data!
                            .where((tag) => tag.action == widget.action))
                          ListTile(
                              title: TagWidget(tag: tag),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  bool? delete = await showYesNoDialog(
                                    context: context,
                                    message:
                                        '"${tag.name}"  adlı kategoriyi silmek istediğinize emin misiniz?',
                                  );
                                  if (delete == true) {
                                    dbServ.deleteTag(tag);
                                  }
                                },
                              ),
                              onTap: () {
                                Navigator.pop(context, tag);
                              })
                      ]);
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            )));
  }
}
