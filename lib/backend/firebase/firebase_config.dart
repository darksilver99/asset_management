import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBSyVXyWVQTwGN0AwCabTzVw5hxB5zTtFQ",
            authDomain: "asset-management-ji0msv.firebaseapp.com",
            projectId: "asset-management-ji0msv",
            storageBucket: "asset-management-ji0msv.firebasestorage.app",
            messagingSenderId: "111745984502",
            appId: "1:111745984502:web:13dc4373b5d0f78803c9d7"));
  } else {
    await Firebase.initializeApp();
  }
}
