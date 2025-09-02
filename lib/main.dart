import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(title: const Text('Tasky')),
      body: SafeArea(child: Column(children: [

      ],
    )),
    );
  }
}
// 1- add package flutter_native_splash in pubspec.yaml part of dependencies

// 2- design splash android and ios screens
//    download splash images (icon) in assets folder say splash_ios_android_11.png

// 3- design splash android 12 screen
//    # in figma create frame w:640 h:640 and r:320 and center the icon in this frame
//    # create new frame w:960 h:960 and center the last frame in this frame
//    # final export the frame as png and name it splash_ios_android_12.png

// 4- create file in rote app flutter_native_splash.yaml
//    # writhe in this code in this file 
      // flutter_native_splash:
      //   color: "#5F33E1"
      //   image: assets/icons/splash_ios_android_11.png
      //   android_12:
      //     image: assets/icons/splash_android_12.png
      //     color: "#5F33E1"
// 4- run => dart run flutter_native_splash:create --path=flutter_native_splash.yaml