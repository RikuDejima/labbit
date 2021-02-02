import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:labbit/pages/create_account.dart';
import 'package:labbit/models/user.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
FirebaseFirestore firestore = FirebaseFirestore.instance;
// final StorageReference storageRef = FirebaseStorage.instance.ref();
final CollectionReference usersRef =
    FirebaseFirestore.instance.collection('users');
final CollectionReference postsRef =
    FirebaseFirestore.instance.collection('posts');
final DateTime timestamp = DateTime.now();
User currentUser;
//グーグルサイン認証、firebaseでtodoの更新などを行う

class MyHomePage extends StatefulWidget {
  //statefulWidgetは引数を受け取るための場所
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;
  // User currentUser;

  @override
  void initState() {
    super.initState();
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
    final GoogleSignInAccount user = googleSignIn.currentUser;
    print(user);
    final DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("usersRef")
        .doc(user.id)
        .get();

    if (!doc.exists) {
      final username = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateAccount()));
      usersRef.doc(user.id).set({
        "id": user.id,
        "username": username,
        // "photoUrl": user.photoUrl,
        "email": user.email,
        // "displayName": user.displayName,
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
      appBar: AppBar(
          toolbarHeight: 70,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/images/appbar_icon/hamburger_menu.png",
                fit: BoxFit.cover,
                height: 32,
              ),
              Image.asset(
                "assets/images/appbar_icon/labbit_logo.png",
                fit: BoxFit.cover,
                height: 32,
              ),
              Image.asset(
                "assets/images/appbar_icon/user_icon.png",
                fit: BoxFit.cover,
                height: 32,
              ),
            ],
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xffFFFEEB),

      floatingActionButton: FloatingActionButton(
        onPressed: () => print("pressed"),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
