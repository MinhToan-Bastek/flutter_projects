import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS){
      return const FirebaseOptions(
          apiKey: 'AIzaSyDuRVuXmIJPm43YGusG750E2LfBPKuOg90',
          appId: '1:353133426077:ios:88f6e9298807254f612b74',
          messagingSenderId: '353133426077',
          projectId: 'app-eco',
        iosBundleId: 'com.example.flutterAppEco'
      );
    } else{
      return const FirebaseOptions(
          apiKey: 'AIzaSyDNmVYrhgmvbsAKY0wZH8lLwlB2TEaDiGI',
          appId: '1:353133426077:android:7d32441b0a57e656612b74',
          messagingSenderId: '353133426077',
          projectId: 'app-eco');
    }
  }
}