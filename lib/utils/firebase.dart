import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
final dynamic storageRef = FirebaseStorage.instance.ref();
final CollectionReference usersRef =
    FirebaseFirestore.instance.collection('users');
final CollectionReference postsRef =
    FirebaseFirestore.instance.collection('posts');

class FireStore {
  getPostsData() async {
    QuerySnapshot snapshot =
        await postsRef.doc(user.id).collection("usersPosts").get();
  }
}
