// ignore_for_file: avoid_print

// import 'package:chamber_of_commerce/add.dart';
// import 'package:chamber_of_commerce/detail.dart';
import 'package:chamber_of_commerce/firebase_options.dart';
import 'package:chamber_of_commerce/navigation.dart';
import 'package:chamber_of_commerce/pages/admin/adminHome.dart';
import 'package:chamber_of_commerce/pages/user/Almanac.dart';
import 'package:chamber_of_commerce/pages/user/Business.dart';
import 'package:chamber_of_commerce/pages/user/Business_listing.dart';
import 'package:chamber_of_commerce/pages/user/Home.dart';
import 'package:chamber_of_commerce/theme/theme.dart';
import 'package:chamber_of_commerce/theme/theme_provider.dart';
import 'package:chamber_of_commerce/widgets/BottomNavBar.dart';
import 'package:chamber_of_commerce/widgets/GridScreen.dart';
import 'package:chamber_of_commerce/widgets/SearchMoreIcon.dart';
import 'package:chamber_of_commerce/widgets/TopNav.dart';
import 'package:chamber_of_commerce/widgets/expandedPanel.dart';
import 'package:chamber_of_commerce/widgets/filterResult.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Assuming you have initialized Firebase in your main function
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( ChangeNotifierProvider(
  create: (context) => ThemeProvider(), // Replace with your provider
  child: 
    MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
    
    debugShowCheckedModeBanner: false,
    
    theme: Provider.of<ThemeProvider>(context).themeData,
  
      home:Home(),
     
     routes: routes,
  
  );
  }
}

