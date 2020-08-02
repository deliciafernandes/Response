var firebaseConfig = {
    apiKey: "AIzaSyD8n489u42cpEtLri2GWP9XCWSN7U_6LKE",
    authDomain: "disaster-alert-3f948.firebaseapp.com",
    databaseURL: "https://disaster-alert-3f948.firebaseio.com",
    projectId: "disaster-alert-3f948",
    storageBucket: "disaster-alert-3f948.appspot.com",
    messagingSenderId: "675930787099",
    appId: "1:675930787099:web:bca50d40f08b604cbb17be",
    measurementId: "G-DCB1BKJ6MG"
  };
  // Initialize Firebase
var firebase = firebase.initializeApp(firebaseConfig);
var auth = firebase.auth();
var db = firebase.firestore();



db.collection("RealNews").orderBy("date", "desc").limit(1)
    .get()
    .then(function(querySnapshot) {
        querySnapshot.forEach(function(doc) {
            // doc.data() is never undefined for query doc snapshots
            document.getElementById('data').innerHTML = doc.data().headline;        
        news = {
          type : "basic", 
          iconUrl: "icon_new.png",
          title : "Latest News Alerts",
          message : doc.data().headline + doc.data().url
          };

          chrome.notifications.create(news,callback );

            console.log(doc.id, " => ", doc.data());
        });
    })
    .catch(function(error) {

        console.log("Error getting documents: ", error);
    });

          

function callback(){
  console.log('Popup done!');
}
