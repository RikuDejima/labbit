import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
FirebaseFirestore firestore = FirebaseFirestore.instance;
final dynamic storageRef = FirebaseStorage.instance.ref();
final CollectionReference usersRef =
    FirebaseFirestore.instance.collection('users');
final CollectionReference postsRef =
    FirebaseFirestore.instance.collection('posts');
final GoogleSignInAccount user = googleSignIn.currentUser;

Map<String, dynamic> docsLength;
int habitLength;

class FireStore {
  getPostsData() async {
    DocumentSnapshot usersPostsSnapshot = await postsRef.doc(user.id).get();

    docsLength = usersPostsSnapshot.data();

    print(docsLength["habitLength"]);
    print(docsLength["habitLength"].runtimeType);
    return habitLength = docsLength["habitLength"];
  }
}
