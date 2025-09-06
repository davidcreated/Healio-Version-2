import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healio_version_2/app/routes/approutes.dart'; 
import 'package:firebase_core/firebase_core.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // no firebase_options.dart here
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // ✅ Changed to GetMaterialApp for GetX routing & state management
      debugShowCheckedModeBanner: false,
       theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
       // Set the initial route for the app
      initialRoute: AppRoutes.splashPage1,
       // Define all the pages/routes for the app
      getPages: AppRoutes.pages,
    );
  } 
}

 