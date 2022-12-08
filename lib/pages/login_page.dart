// ignore_for_file: unused_import

import 'package:vks/functions.dart';
import 'package:vks/services/auth_service.dart';
import 'package:vks/services/theme_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

enum LoginAction { newUser, deleteUser }

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.action = LoginAction.newUser})
      : super(key: key);

  final LoginAction action;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  late AuthService authServ;

  bool isSignIn = true;
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    authServ = context.read<AuthService>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: InkWell(
          onTap: () {
            focus1.unfocus();
            focus2.unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(),
                      SvgPicture.asset(
                        'assets/expenses-history.svg',
                        height: 70,
                        width: 70,
                      ),
                      hgh(30),
                      TextField(
                        focusNode: focus1,
                        controller: email,
                        decoration: const InputDecoration(
                          labelText: 'e-posta',
                        ),
                      ),
                      hgh(defaultPadding),
                      TextField(
                        focusNode: focus2,
                        controller: password,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                            labelText: 'şifre',
                            suffixIcon: IconButton(
                              icon: Icon(obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                            )),
                      ),
                      hgh(15),
                      ElevatedButton(
                          onPressed: onSignIn,
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size.fromHeight(56),
                          ),
                          child: Text(
                              widget.action == LoginAction.deleteUser
                                  ? 'Delete User'
                                  : isSignIn
                                      ? 'Giriş Yap'
                                      : 'Kayıt Ol',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24))),
                      const Spacer(),
                      if (widget.action == LoginAction.newUser)
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: isSignIn
                                      ? 'Henüz bir hesabınız yok mu? '
                                      : 'Kayıtlı bir hesabım var.  ',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                                  children: [
                                    TextSpan(
                                        text:
                                            isSignIn ? 'Kayıt Ol' : 'Giriş Yap',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            setState(() {
                                              isSignIn = !isSignIn;
                                            });
                                          },
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary))
                                  ])),
                        )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onSignIn() async {
    String? message;
    if (widget.action == LoginAction.deleteUser) {
      await authServ.deleteAccount(email.text, password.text);
      if (mounted) {
        Navigator.pop(context);
        message = 'Hesap başarıyla silindi';
      }
    } else if (isSignIn) {
      message = await showLoadingDialog(
        context: context,
        task: authServ.signInWithEmailAndPassword(email.text, password.text),
      );
    } else {
      message = await showLoadingDialog(
        context: context,
        task: authServ.registerWithEmailAndPassword(email.text, password.text),
      );
    }
    if (mounted && message != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }
}
