
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iwish_app/CloudDatabase/firebaseAuthService.dart';
import 'package:iwish_app/Models/donations.dart';
import 'package:iwish_app/Models/enquiry.dart';
import 'package:iwish_app/Models/events.dart';
import 'package:iwish_app/Models/posts.dart';
import 'package:iwish_app/Models/requests.dart';


import 'dart:async';
import 'package:meta/meta.dart';
import 'firestore_service.dart';
import 'firestore_path.dart';

/*


class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  // User Account
  final CollectionReference userCollection = Firestore.instance.collection('Users');

  //Requests
  final CollectionReference requestCollection = Firestore.instance.collection('Users/VpbJZ7AZ04NKCifOekUbdVCDqPe2/UserRequests');


  // user data from snapshots
  iWishUser _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return iWishUser(
        uid: uid,
        username: snapshot.data['username'],
        email: snapshot.data['email'],
    );
  }

  // get user doc stream
  Stream<iWishUser> get userData {
    return userCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }
  //update user data
  Future<void> updateUserData(String username, String email) async {
    return await userCollection.document(uid).setData({
      'username': username,
      'email': email,
    });
  }


  // request list from snapshot
  List<Request> _requestListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Request(
          category: doc.data['category'] ?? '',
          city: doc.data['city'] ?? '',
          info: doc.data['info'] ?? '',
          subcategory: doc.data['subcategory'] ?? '',
          status: doc.data['status'] ?? '',
          requestedby: doc.data['requestedby'] ?? '',

      );
    }).toList();
  }

  // get requests stream
  Stream<List<Request>> get requests  {
    //var myUserId = AuthService.auth().currentUser.uid;
    return requestCollection.where('requestedby', isEqualTo: 'sharmaabhinav123@gmail.com' ).snapshots()
        .map(_requestListFromSnapshot);
  }


 */

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase {
  FirestoreDatabase({@required this.uid})
      : assert(uid != null, 'Cannot create FirestoreDatabase with null uid');
  final String uid;

  final _service = FirestoreService.instance;

  //Donations

  // add donation
  Future<void> setDonation(Donation donation) => _service.setData(
    path: FirestorePath.donation(uid, donation.id),
    data: donation.toMap(),
  );


  // delete donation
  Future<void> deleteDonation(Donation donation) async {
    await _service.deleteData(path: FirestorePath.donation(uid, donation.id));
  }

  Future getDocs() async {
    QuerySnapshot querySnapshot = await Firestore.instance.collectionGroup("donations").getDocuments();
    for (int i = 0; i < querySnapshot.documents.length; i++) {
      var a = querySnapshot.documents[i];
      print('ID:');
      print(a.documentID);
    }
  }

  // get list of donation
  Stream<List<Donation>> donationsStream() => _service.collectionStream(
    path: FirestorePath.donations(uid),
    builder: (data, documentId) => Donation.fromMap(data, documentId),
  );

  //Donations

  // add donation
  Future<void> setRequest(Request request) => _service.setData(
    path: FirestorePath.request(uid, request.id),
    data: request.toMap(),
  );

  // delete donation
  Future<void> deleteRequest(Request request) async {
    await _service.deleteData(path: FirestorePath.request(uid, request.id));
  }

  // get list of donation
  Stream<List<Request>> requestsPStream() => _service.collectionStream(
    path: FirestorePath.requests(uid),
    builder: (data, documentId) => Request.fromMap(data, documentId),
  );
  // get list of donation
  Stream<List<Request>> requestsDStream() => _service.collectionStream(
    path: FirestorePath.requests(uid),
    builder: (data, documentId) => Request.fromMap(data, documentId),
  );


  //Posts

  // add post
  Future<void> setPost(Post post) => _service.setData(
    path: FirestorePath.post(uid, post.id),
    data: post.toMap(),
  );

  // delete donation
  Future<void> deletePost(Post post) async {
    await _service.deleteData(path: FirestorePath.post(uid, post.id));
  }

  // get list of donation
  Stream<List<Post>> postsStream() => _service.collectionStream(
    path: FirestorePath.posts(uid),
    builder: (data, documentId) => Post.fromMap(data, documentId),
  );

  Future<String> countDocuments() async {
    QuerySnapshot _myDoc = await Firestore.instance.collection('posts').getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    return _myDocCount.length.toString();  // Count of Documents in Collection
  }

  //Enquiries
  // add post
  Future<void> setEnquiry(Enquiry enquiry) => _service.setData(
    path: FirestorePath.enquiry(uid, enquiry.id),
    data: enquiry.toMap(),
  );

  // delete donation
  Future<void> deleteEnquiry(Enquiry enquiry) async {
    await _service.deleteData(path: FirestorePath.enquiry(uid, enquiry.id));
  }

  // get list of donation
  Stream<List<Enquiry>> enquiryStream() => _service.collectionStream(
    path: FirestorePath.enquiries(uid),
    builder: (data, documentId) => Enquiry.fromMap(data, documentId),
  );


  //Events

  // add post
  Future<void> setEvent(Event event) => _service.setData(
    path: FirestorePath.event(uid, event.id),
    data: event.toMap(),
  );

  // delete donation
  Future<void> deleteEvent(Event event) async {
    await _service.deleteData(path: FirestorePath.event(uid, event.id));
  }

  // get list of donation
  Stream<List<Event>> eventsStream() => _service.collectionStream(
    path: FirestorePath.events(uid),
    builder: (data, documentId) => Event.fromMap(data, documentId),
  );

}

