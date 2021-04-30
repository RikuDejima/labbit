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

class FireStore {
  getPostsData(data) async {
    final Map firestore_dict = {};

    dictAdd(data) {
      firestore_dict["$data"] = data;
    }

    final QuerySnapshot usersPosts_snapshot =
        await postsRef.doc(user.id).collection("usersPosts").get();
    dictAdd(usersPosts_snapshot);

    final docs_length = usersPosts_snapshot.docs.length;
    dictAdd(docs_length);

    return firestore_dict[data];
  }
}
