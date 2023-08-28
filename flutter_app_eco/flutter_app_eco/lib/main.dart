import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_eco/constants/theme.dart';
import 'package:flutter_app_eco/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:flutter_app_eco/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:flutter_app_eco/provider/app_provider.dart';
import 'package:flutter_app_eco/screens/auth_ui/welcome/welcome.dart';
import 'package:flutter_app_eco/screens/home/home.dart';
import 'package:provider/provider.dart';

import 'firebase_helper/firebase_options/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Eco App',
        theme: themeData,
        home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return const CustomBottomBar();
            }
            return const Welcome();
          },
        )
      ),
    );
  }
}

