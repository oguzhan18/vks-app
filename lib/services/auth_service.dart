import 'dart:async';

import 'package:vks/functions.dart';
import 'package:vks/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

enum AuthState { emailVerification, signedIn, loading, unsignedIn, deleteUser }

class AuthService {
  AuthService(this.databaseService) {
    auth
        .userChanges()
        .listen((user) => authStateCont.sink.add(_mapUserToAuthState(user)));
  }

  DatabaseService databaseService;
  final auth = FirebaseAuth.instance;
  StreamController<AuthState> authStateCont = BehaviorSubject<AuthState>();
  Stream<AuthState> get authStateStream => authStateCont.stream;

  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    // authStateCont.sink.add(AuthState.loading);
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return formatFirebaseAuthExceptionCode(e.code);
    }
    return null;
  }

  Future<String?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return formatFirebaseAuthExceptionCode(e.code);
    }
    return null;
  }

  Future<void> signOut() async {
    print('AuthService.signOut()');
    authStateCont.sink.add(AuthState.loading);
    await auth.signOut();
  }

  Future<void> deleteAccount(String email, String password) async {
    await signInWithEmailAndPassword(email, password);
    await auth.currentUser!.delete();
  }

  Future<void> sendVerificationEmail() async {
    await auth.currentUser!.sendEmailVerification();
  }

  Future<void> changeEmail(String newEmail) async {
    await auth.currentUser!.updateEmail(newEmail);
  }

  AuthState _mapUserToAuthState(User? user) {
    if (user != null) {
      if (user.emailVerified == true || user.isAnonymous) {
        return AuthState.signedIn;
      }
      return AuthState.emailVerification;
    }
    return AuthState.unsignedIn;
  }
}
