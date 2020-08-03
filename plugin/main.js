

var firebaseConfig = {
    apiKey: "AIzaSyA4xj7lKyCXkhapt2xDzWFf0YzzVVgSlAU",
    authDomain: "disastermg-a78fc.firebaseapp.com",
    databaseURL: "https://disastermg-a78fc.firebaseio.com",
    projectId: "disastermg-a78fc",
    storageBucket: "disastermg-a78fc.appspot.com",
    messagingSenderId: "354909014882",
    appId: "1:354909014882:web:7b65ca09b5a2e842a0ba3b",
    measurementId: "G-WYPR7JRG03"
  };

var credential = firebase.auth.GoogleAuthProvider.credential(null, token);
firebase.auth().signInWithCredential(credential);
