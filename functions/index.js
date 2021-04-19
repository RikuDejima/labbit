// const functions = require("firebase-functions");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

// import * as functions from "firebase-functions";

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript

// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const admin = require('firebase-admin');
const functions = require('firebase-functions');

admin.initializeApp(functions.config().firebase);

const db = admin.firestore();

// const batch = db.batch();

const postsRef = db.collection('posts');
// const func = functions.logger 
// .doc('112863960669202701170').collection("usersPosts");

// let now = DateTime().now();

exports.restPostsData = functions.https.onRequest((request, response) => {
    response.status(200).send('whatsup!');
    postsRef.get().then( snapshot => { //posts.doc()
      
      console.log(snapshot,"スナップショット")
        snapshot.docs.map(doc => {  
          
          try {
            console.log("ハロー絶望");
            console.log(doc,"ドック");
            console.log(doc.id, "ID");
            var usersPostsRef = postsRef.doc(doc.id).collection("usersPosts"); // doc 数学,筋トレ
    
            console.log(usersPostsRef,"usersPostsRef");
            // usersPostsRef.map(doc => {
            //   console.log(doc);
            //   console.log(doc.id, "ID");
            //   console.log(doc.data());
            // });
            usersPostsRef.get().then( snapshot => {
              console.log(snapshot,"スナップショット")
              snapshot.forEach(doc => {
                console.log(doc);
                console.log(doc.id, "ID");
                console.log(doc.data());
                usersPostsRef.doc(doc.id).ref().update({
                  "complete_day":0
                })
              })
            })
          } catch(e) {
            console.log(e.message);
          }
        });
      
    });

  
    // func.log("ok")
});