

import 'package:flutter/material.dart';
import 'package:shoes_store/controllers/mainscreen_provider.dart';
import 'package:shoes_store/views/ui/mainscreen.dart';
import 'package:provider/provider.dart';

import 'controllers/product_provider.dart';

void main() {

    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>MainScreenNotifier()),
        ChangeNotifierProvider(create: (context)=>ProductNotifier()),
      ],

      child: const MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainScreen(),
    );
  }
}


