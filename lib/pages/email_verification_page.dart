import 'dart:async';

import 'package:vks/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({Key? key}) : super(key: key);

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  late AuthService authServ;

  @override
  void initState() {
    super.initState();
    authServ = context.read<AuthService>();
    authServ.sendVerificationEmail();

    Timer.periodic(const Duration(seconds: 3), (timer) async {
      await authServ.auth.currentUser!.reload();
      if (authServ.auth.currentUser?.emailVerified == true) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(authServ.auth.currentUser!.email!),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('E-postanıza bir doğrulama e-postası gönderildi.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 40,
                ),
                ElevatedButton.icon(
                    icon: const Icon(Icons.email),
                    label: const Text('Tekrar doğrulama e-postası gönder.'),
                    onPressed: () async {
                      authServ.sendVerificationEmail();
                    }),
                TextButton(
                    child: const Text('İptal'),
                    onPressed: () async {
                      authServ.signOut();
                    }),
              ]),
        ));
  }
}
