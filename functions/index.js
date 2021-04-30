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

const admin = require('firebase-admin');
const functions = require('firebase-functions');

admin.initializeApp(functions.config().firebase);

const db = admin.firestore();

const postsRef = db.collection('posts');

// functions.region('asia-northeast1').pubsub.schedule('0 0 * * *').onRun((_)

exports.restPostsData =  functions.region('asia-northeast1').pubsub.schedule('0 0 * * *').onRun((_) => {
    // response.send("Hello from Firebase!");

    postsRef.get().then( snapshot => { //posts.doc()
        snapshot.docs.map(doc => {  
          try {
            const usersPostsRef = postsRef.doc(doc.id).collection("usersPosts"); // doc 数学,筋トレ
    
            usersPostsRef.get().then( snapshot => {
              snapshot.forEach(doc => {
                const habit_data = doc.data()
                const firstTime_Date = habit_data["first_time"].toDate()
                const completeTime_Date = habit_data["complete_time"].toDate()
                const targetTime_hours = Number(habit_data["targetTime_hours"])
                const targetTime_minites = Number(habit_data["targetTime_minutes"])
                firstTime_Date.setHours(firstTime_Date.getHours() + targetTime_hours)
                firstTime_Date.setMinutes(firstTime_Date.getMinutes() + targetTime_minites)
                const addedFirstTime = firstTime_Date
                const complete_day = habit_data["complete_day"]    

                if(completeTime_Date > addedFirstTime){ //true = 目標時間達成
                  usersPostsRef.doc(doc.id).update({
                    "complete_day":complete_day + 1 //習慣化日数更新
                  })  
                } else {
                  usersPostsRef.doc(doc.id).update({
                    "complete_day":0
                  })  
                }

                usersPostsRef.doc(doc.id).update({ //リセット
                  "complete_time":0,
                  "first_time":0
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
