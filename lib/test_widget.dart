// ignore_for_file: unused_import

import 'dart:async';

import 'package:vks/services/auth_service.dart';
import 'package:vks/services/theme_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

class TestWidget extends StatefulWidget {
  TestWidget({Key? key}) : super(key: key);

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  late ThemeService thNot;

  @override
  void initState() {
    super.initState();
    thNot = context.read<ThemeService>();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(size);
    return Scaffold(
        appBar: AppBar(
          title: Text('Test Widget'),
        ),
        body: Column(
          children: [
            TextButton(
              child: Text('light'),
              onPressed: () {
                thNot.setCurThemeMode(ThemeMode.light);
              },
            ),
            TextButton(
              child: Text('dark'),
              onPressed: () {
                thNot.setCurThemeMode(ThemeMode.dark);
              },
            ),
          ],
        ));
  }
}
