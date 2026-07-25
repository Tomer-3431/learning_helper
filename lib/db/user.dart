import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:learning_helper/db/db_constants.dart';
import 'package:learning_helper/util/utils.dart';

class User {
  final String uid;
  String name;
  String email;

  User({required this.uid, this.name = anonyName, this.email = anonyEmail});

  User.fromUID({required this.uid, String? name, String? email})
    : name = anonyName,
      email = anonyEmail {
    try {
      final ref = FirebaseDatabase.instance.ref('users/$uid');
      if (name != null) {
        this.name = name;
      } else {
        _setNameFromData(ref);
      }
      if (email != null) {
        this.email = email;
      } else {
        _setEmailFromData(ref);
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) print('FirebaseAuth Exception ${e.code} - defaulting user');
    } on FirebaseException catch (e) {
      if (kDebugMode) print('Firebase Exception ${e.code} - defaulting user');
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  void _setNameFromData(DatabaseReference ref) async {
    var event = await ref.child('name').once();
    name = tryCast(event.snapshot.value) ?? '';
  }

  void _setEmailFromData(DatabaseReference ref) async {
    var event = await ref.child('email').once();
    email = tryCast(event.snapshot.value) ?? '';
  }
}
