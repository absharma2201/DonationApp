//library firebase_auth_service;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iwish_app/CloudDatabase/firestore_service.dart';
import 'package:iwish_app/CloudDatabase/storageService.dart';
import 'package:iwish_app/Models/iWishUser.dart';
import 'package:iwish_app/CloudDatabase/databaseService.dart';
import 'package:flutter/foundation.dart';

/*
class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // create user obj based on firebase user
  iWishUser _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? iWishUser(uid: user.uid) : null;
  }

  // GET UID
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }


  // auth change user stream
  Stream<iWishUser> get user {
    return _firebaseAuth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }
/*
  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  */

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String username,String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(username, email);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}
*/

@immutable
class User {
  User({
    @required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
  }) : assert(uid != null, 'User can only be created with a non-null uid');

  final String uid;
  final String email;
  final String displayName;
  String photoUrl = '';

  factory User.fromFirebaseUser(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoUrl,
    );
  }

  @override
  String toString() =>
      'uid: $uid, email: $email, displayName: $displayName, avatarUrl: $photoUrl';

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
    };
  }
}

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _service = FirestoreService.instance;

  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged
        .map((firebaseUser) => User.fromFirebaseUser(firebaseUser));
  }

  Future<User> signInAnonymously() async {
    final AuthResult authResult = await _firebaseAuth.signInAnonymously();
    return User.fromFirebaseUser(authResult.user);
  }


  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final AuthResult authResult = await _firebaseAuth
        .signInWithCredential(EmailAuthProvider.getCredential(
      email: email,
      password: password,
    ));
    return User.fromFirebaseUser(authResult.user);
  }

  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    final AuthResult authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    await _service.createUser(User(
        uid: authResult.user.uid,
        email: authResult.user.email,
        displayName: 'iWisher',
        photoUrl: ''));

    return User.fromFirebaseUser(authResult.user);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<User> currentUser() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    return User.fromFirebaseUser(user);
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}

