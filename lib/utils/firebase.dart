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

int habitLength;
Map<String, dynamic> postsDocData;
DocumentSnapshot usersPostSnapshot;
QuerySnapshot usersPostsHabitSnapshot;
List habits = [];
List habitData = [];

void getPostsData() async {
  usersPostSnapshot = await postsRef.doc(user.id).get();

  postsDocData = usersPostSnapshot.data();
  habitLength = postsDocData["habitLength"];
  usersPostsHabitSnapshot =
      await postsRef.doc(user.id).collection("usersPosts").get();
  habits = usersPostsHabitSnapshot.docs;
}
