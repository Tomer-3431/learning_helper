import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:learning_helper/db/global.dart';
import 'package:learning_helper/db/user.dart';
import 'package:learning_helper/home/home_screen.dart';
import 'package:learning_helper/login/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void setCurrentUser({
  required String userId,
  required String name,
  required String email,
  String? photoURL,
}) {
  isAnonymous = false;
  currentUser = User(uid: userId, name: name, email: email, photoURL: photoURL);
}

void getCurrentUser({
  required String userId,
  String? name,
  String? email,
  String? photoURL,
}) {
  isAnonymous = false;
  currentUser = User.fromUID(
    uid: userId,
    name: name,
    email: email,
    photoURL: photoURL,
  );
}

Future<void> createDatabaseUser({
  required String userId,
  required String name,
  required String email,
  String? photoURL,
}) async {
  final DatabaseReference userRefrence = FirebaseDatabase.instance.ref(
    'users/$userId',
  );

  await userRefrence.set({'name': name, 'email': email, 'photoURL': ?photoURL});
}

Future<void> saveUserPrefs(User user) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('user/uid', user.uid);
  await prefs.setString('user/email', user.email);
  if (user.photoURL != null) {
    await prefs.setString('user/photoUrl', user.photoURL!);
  }
}

Future<void> checkPrefs(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();

  final userId = prefs.getString('user/uid');
  final email = prefs.getString('user/email');
  final name = prefs.getString('user/name');
  final photoUrl = prefs.getString('user/photoUrl');

  if (userId == null || email == null || name == null) return;

  isAnonymous = false;
  currentUser = User(uid: userId, email: email, name: name, photoURL: photoUrl);

  if (context.mounted) {
    navigateToHome(context);
  }
}

Future<void> removePrefs() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.remove('user/uid');
  await prefs.remove('user/name');
  await prefs.remove('user/email');
  await prefs.remove('user/photoUrl');
}

Future<bool> isNewUser(String userId) async {
  final snapshot = await FirebaseDatabase.instance.ref('users/$userId').get();
  return !snapshot.exists;
}

void navigateToHome(BuildContext context) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) {
        return HomeScreen();
      },
    ),
  );
}

void logout(BuildContext context) {
  FirebaseAuth.instance.signOut();
  removePrefs();
  isAnonymous = true;
  currentUser = null;

  if (context.mounted) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => SigninScreen()));
  }
}

Widget logoutAction(BuildContext context) {
  return IconButton(
    onPressed: () => logout(context),
    icon: Icon(Icons.logout, color: Colors.black),
  );
}
