import 'package:learning_helper/db/db_constants.dart';

class User {
  final String uid;
  String name;
  String email;

  User({
    required this.uid,
    this.name = anonyName,
    this.email = anonyEmail,
  });
}