import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:labbit/pages/create_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:labbit/models/user.dart';
import 'package:labbit/pages/addtodo.dart';
import 'package:labbit/widgets/header.dart';
import 'package:labbit/pages/timer.dart';
import 'package:labbit/pages/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:labbit/models/stop_watch_model.dart';

PageController pageController;
final GoogleSignIn googleSignIn = GoogleSignIn();
FirebaseFirestore firestore = FirebaseFirestore.instance;
final dynamic storageRef = FirebaseStorage.instance.ref();
final CollectionReference usersRef =
    FirebaseFirestore.instance.collection('users');
final CollectionReference postsRef =
    FirebaseFirestore.instance.collection('posts');
final DateTime timestamp = DateTime.now();
final GoogleSignInAccount user = googleSignIn.currentUser;
User currentUser;
//グーグルサイン認証、firebaseでtodoの更新などを行う

class MyHomePage extends StatefulWidget {
  //statefulWidgetは引数を受け取るための場所
  // MyHomePage({Key key, this.title}) : super(key: key);

  // final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isAuth = false;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    print("I called !");
    pageController = PageController();
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print("Error signing in: $err");
    });

    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    });
  }

  // stopWatch.getPostsData();

  handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      createUserInFirestore();
      print("User signed in!: $account");
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  createUserInFirestore() async {
    print(user);
    final DocumentSnapshot doc = await usersRef.doc(user.id).get();

    if (!doc.exists) {
      print("yes");
      final username = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateAccount()));
      usersRef.doc(user.id).set({
        "id": user.id,
        "username": username,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        // "bio": "",
        "timestamp": timestamp,
      });
    }
    currentUser = User.fromDocument(doc);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  login() {
    googleSignIn.signIn();
    print(isAuth);
  }

  logout() {
    googleSignIn.signOut();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  buildAuthScreen() {
    return Scaffold(
      appBar: header(),
      body: Center(
        child: FutureBuilder<Object>(builder: (context, snapshot) {
          return PageView(
            children: <Widget>[
              FutureBuilder<QuerySnapshot>(
                  future: postsRef.doc(user.id).collection("usersPosts").get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot);
                      final List<DocumentSnapshot> documents =
                          snapshot.data.docs;

                      return ListView(
                        children: documents.map((document) {
                          return Card(
                            child: ListTile(
                              title: Text(document.id),
                            ),
                          );
                        }).toList(),
                      );
                    }
                    return Center(
                      child: Text('読込中...'),
                    );
                  }),
              StopWatch(),
              Notifications(),
              AddTodo(),
            ],
            controller: pageController,
            onPageChanged: onPageChanged,
            physics: NeverScrollableScrollPhysics(),
          );
        }),
      ),
      backgroundColor: Color(0xffFFFEEB),
      floatingActionButton: Visibility(
        visible: pageIndex != 3 ? true : false,
        child: FloatingActionButton(
          onPressed: () {
            pageController.animateToPage(3,
                duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 35.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.av_timer_rounded),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
          ),
        ],
      ),
    );
  }

  Scaffold buildUnAuthScreen() {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor
            ],
            begin: Alignment.topRight,
            end: Alignment.topLeft,
          )),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "labbit",
                style: TextStyle(
                    // fontFamily: "Signatra",
                    fontSize: 40.0,
                    color: Colors.white),
              ),
              GestureDetector(
                onTap: () => login(),
                child: Container(
                  width: 260.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/google_signin_button.png"),
                          fit: BoxFit.cover)),
                ),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
