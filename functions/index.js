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
// .doc('112863960669202701170').collection("usersPosts");

// let now = DateTime().now();

exports.restPostsData = functions.region('asia-northeast1')
  .pubsub.schedule('0 0 * * *').timeZone('Asia/Tokyo').onRun( async () => {

    postsRef.get().then( snapshot => {
      snapshot.forEach(doc => {

        var usersPostsRef = postsRef.doc(doc.id).collection("usersPosts")

        usersPostsRef.get().then( snapshots => {
          snapshots.forEach(docs => {

            usersPostsRef.doc(docs.id).ref().update(
              {complete_day: 20}
            );
          });
        });
      });
    });

    // batch.update(postsRef, {complete_day: 30})
    // await batch.commit();
});