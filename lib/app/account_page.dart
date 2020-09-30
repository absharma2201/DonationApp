import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iwish_app/CloudDatabase/alert_dialogs.dart';
import 'package:iwish_app/CloudDatabase/databaseService.dart';
import 'package:iwish_app/CloudDatabase/firebaseAuthService.dart';
import 'package:iwish_app/CloudDatabase/storageService.dart';
import 'package:iwish_app/UIPages/avatar.dart';
import 'package:iwish_app/UIPages/keys.dart';
import 'package:iwish_app/UIPages/strings.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedantic/pedantic.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final Firestore db = Firestore.instance;
  var _post_count;

  @override
  void initState() {
    super.initState();
    _queryDb();
  }

  Future<void> _queryDb() async {
    // Make a Query
  //  Query query = db.collectionGroup('posts');
    QuerySnapshot querySnapshot = await db.collectionGroup('posts').getDocuments();
    _post_count = querySnapshot.documents.length.toString();

  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final FirebaseAuthService auth =
          Provider.of<FirebaseAuthService>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      unawaited(showExceptionAlertDialog(
        context: context,
        title: Strings.logoutFailed,
        exception: e,
      ));
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final bool didRequestSignOut = await showAlertDialog(
          context: context,
          title: Strings.logout,
          content: Strings.logoutAreYouSure,
          cancelActionText: Strings.cancel,
          defaultActionText: Strings.logout,
        ) ??
        false;
    if (didRequestSignOut == true) {
      await _signOut(context);
    }
  }

  Future<void> getData(userID) async {
// return await     Firestore.instance.collection('users').document(userID).get();
    DocumentSnapshot result = await Firestore.instance.collection('users')
        .document(userID)
        .get();
    return result;
  }



    Widget _buildUserInfo(BuildContext context, user) {

      final StorageService storage = Provider.of<StorageService>(context, listen: false);

      return Column(
        children: [
          Avatar(
            photoUrl: user['photoUrl'], //user.photoUrl,
            radius: 50,
            borderColor: Colors.black54,
            borderWidth: 2.0,
            onTap: () async {
              File image = await ImagePicker.pickImage(
                  source: ImageSource.gallery);

              final user_profile_image = await storage.uploadFile(image);
              await Firestore.instance
                  .collection('users')
                  .document(user['uid'])
                  .updateData({
                'photoUrl': user_profile_image,
              });

              setState(() {});
            },
          ),
          const SizedBox(height: 8),
          if (user['email'] != null)
            Text(
              user['email'],
              style: TextStyle(color: Colors.white),
            ),
          const SizedBox(height: 8),
        ],
      );
    }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);


    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFF1b1e44),
                Color(0xFF2d3447),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(Strings.accountPage),
          actions: <Widget>[
            FlatButton(
              key: Key(Keys.logout),
              child: Text(
                Strings.logout,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () => _confirmSignOut(context),
            ),
          ],
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection('users').document(user.uid).snapshots(),
          builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new Text("Loading");
              }
              var userInfo = snapshot.data;
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(userInfo["displayName"], style: TextStyle(color: Colors.white),),
                  _buildUserInfo(context, userInfo),
                ],
              ),
            );
          }
        ),
      ),
    );
  }



}
