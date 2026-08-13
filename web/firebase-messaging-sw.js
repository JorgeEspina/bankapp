importScripts(
  "https://www.gstatic.com/firebasejs/10.13.2/firebase-app-compat.js"
);

importScripts(
  "https://www.gstatic.com/firebasejs/10.13.2/firebase-messaging-compat.js"
);

firebase.initializeApp({
  apiKey: "AIzaSyB7N3Cn_mU10kNN5o4AG55XtqetTH4zSm8",
  appId: "1:873263492033:web:34d9475c8fc84462ea9d40",
  messagingSenderId: "873263492033",
  projectId: "experience-e4e10",
  authDomain: "experience-e4e10.firebaseapp.com",
  storageBucket: "experience-e4e10.firebasestorage.app",
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((message) => {
  console.log("========================================");
  console.log("NOTIFICACIÓN FCM EN SEGUNDO PLANO");
  console.log("Mensaje completo:", message);
  console.log("Message ID:", message.messageId);
  console.log("Título:", message.notification?.title);
  console.log("Mensaje:", message.notification?.body);
  console.log("Datos adicionales:", message.data);
  console.log("========================================");
});