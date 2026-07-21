// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learning_helper/db/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.windows);
  await SharedPreferences.getInstance();

  runApp(
    MaterialApp(
      home: Center(
        child: ElevatedButton(onPressed: testFirebase, child: Text('press')),
      ),
    ),
  );
}

void testFirebase() async {
  if (kDebugMode) {
    var x = await FirebaseDatabase.instance.ref('users/0/test').get();
    print(x.value);
  }
}
