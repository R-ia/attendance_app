import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAQxbvv4ea2CHkoSq1b-q-yTItQcNCSfNY",
          authDomain: "attendanceapp-2e537.firebaseapp.com",
          projectId: "attendanceapp-2e537",
          storageBucket: "attendanceapp-2e537.appspot.com",
          messagingSenderId: "705006522454",
          appId: "1:705006522454:web:3a8c63df6ea0d962dc6bf7",
          measurementId: "G-63RZ4KN1K2"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
/*************  ✨ Codeium Command ⭐  *************/
  /// The widget that is the root of the application.
  ///
  /// Uses [GetMaterialApp] to create a material application with a blue theme.
  /// The home of the application is a [LoginScreen].
  ///
  /// This widget is the root of the application, so it is the widget that is
  /// constructed by [runApp].
/******  aac5824c-2ee8-4819-8860-80d79b5f1497  *******/
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Attendance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
