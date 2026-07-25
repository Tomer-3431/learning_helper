import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:learning_helper/db/db_constants.dart';
import 'package:learning_helper/util/utils.dart';

class User {
  final String uid;
  String name;
  String email;
  String? photoURL;

  User({required this.uid, this.name = anonyName, this.email = anonyEmail, this.photoURL});

  User.fromUID({required this.uid, String? name, String? email, this.photoURL})
    : name = name ?? anonyName,
      email = email ?? anonyEmail {
    try {
      final ref = FirebaseDatabase.instance.ref('users/$uid');
      if (name == null) {
        _setNameFromData(ref);
      }

      if (email == null) {
        _setEmailFromData(ref);
      }
      
      if (photoURL == null) {
        _setPhotoURL(ref);
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

  void _setPhotoURL(DatabaseReference ref) async {
    var event = await ref.child('photoURL').once();
    photoURL = tryCast(event.snapshot.value);
  }
}
