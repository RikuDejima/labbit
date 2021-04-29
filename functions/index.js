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
        snapshot.docs.map(doc => {  
          console.log(doc.id);
          try {
            const usersPostsRef = postsRef.doc(doc.id).collection("usersPosts"); // doc 数学,筋トレ
    
            usersPostsRef.get().then( snapshot => {
              // if (snapshot.exists){
              //   console.log("へい！")
              // }
              snapshot.forEach(doc => {
                const habit_data = doc.data()
                const firstTime_Date = habit_data["first_time"].toDate()
                const completeTime_Date = habit_data["complete_time"].toDate()
                const targetTime_hours = Number(habit_data["targetTime_hours"])
                const targetTime_minites = Number(habit_data["targetTime_minutes"])
                firstTime_Date.setHours(firstTime_Date.getHours() + targetTime_hours)
                firstTime_Date.setMinutes(firstTime_Date.getHours() + targetTime_minites)
                const addedFirstTime = firstTime_Date
                
                if(completeTime_Date > addedFirstTime){
                  usersPostsRef.doc(doc.id).update({
                    "complete_day":0
                  })  
                }
              })
            })
          } catch(e) {
            console.log(e.message);
          }
        });
      
    });

  
    // func.log("ok")
});
