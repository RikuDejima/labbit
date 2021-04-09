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

let db = admin.firestore();

let batch = db.batch();

const postsRef = db.collection('posts').doc('112863960669202701170').collection("usersPosts").doc("筋トレ");

// let now = DateTime().now();

exports.restPostsData = functions.region('asia-northeast1')
  .pubsub.schedule('0 0 * * *').timeZone('Asia/Tokyo').onRun( async () => {
      postsRef.ref().update({"complete_time": 0});
      console.log("ok");
      await batch.commit();
});