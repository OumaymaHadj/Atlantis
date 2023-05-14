import 'package:chat_res/helper/binding.dart';
import 'package:chat_res/routes/route.dart';
import 'package:chat_res/view/home.view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      getPages: routes(),
      initialRoute: "/Splash",
      home: Scaffold(body:HomeView()),
    );
  }
}