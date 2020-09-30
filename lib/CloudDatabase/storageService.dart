import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:iwish_app/CloudDatabase/firebaseAuthService.dart';
import 'package:meta/meta.dart';


class StorageService {

  StorageService({ this.uid});
  final String uid;


  FirebaseStorage _storage =
  FirebaseStorage(storageBucket: "gs://iwishapp-e8b71.appspot.com");
  //AuthRepo _authRepo = locator.get<AuthRepo>();


  Future<String> uploadFile(File file) async {

    var storageRef = _storage.ref().child("user/profile/$uid");
    var uploadTask = storageRef.putFile(file);
    var completedTask = await uploadTask.onComplete;
    String downloadUrl = await completedTask.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> getUserProfileImage(String uid) async {
    return await _storage.ref().child("user/profile/$uid").getDownloadURL();
  }

  Future<String> uploadPostImage(File file, String postId) async {

    var storageRef = _storage.ref().child("posts/$postId");
    var uploadTask = storageRef.putFile(file);
    var completedTask = await uploadTask.onComplete;
    String downloadUrl = await completedTask.ref.getDownloadURL();
    return downloadUrl;
  }
  Future<String> uploadEnquiryImage(File file, String postId) async {

    var storageRef = _storage.ref().child("enquiries/$postId");
    var uploadTask = storageRef.putFile(file);
    var completedTask = await uploadTask.onComplete;
    String downloadUrl = await completedTask.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> uploadEventImage(File file, String eventId) async {

    var storageRef = _storage.ref().child("events/$eventId");
    var uploadTask = storageRef.putFile(file);
    var completedTask = await uploadTask.onComplete;
    String downloadUrl = await completedTask.ref.getDownloadURL();
    return downloadUrl;
  }

}