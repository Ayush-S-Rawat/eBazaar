import 'package:ebazaar/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'consts/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyDQir46hhy1mTULt3YSaaV8o7kJZkNs5UE',
    appId: '1:329283842385:android:a8c8351c7ddef1f1c5e370',
    messagingSenderId: '329283842385',
    projectId: 'ebazaar-b1afc',
    storageBucket: 'gs://ebazaar-b1afc.appspot.com',
  ));
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: darkFontGrey),
          backgroundColor: Colors.transparent,
        ),
        fontFamily: regular,
      ),
      home: SplashScreen(),
    );
  }
}
