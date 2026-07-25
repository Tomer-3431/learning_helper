import 'package:desktop_webview_auth/desktop_webview_auth.dart';
import 'package:desktop_webview_auth/github.dart';
import 'package:desktop_webview_auth/google.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learning_helper/db/global.dart';
import 'package:learning_helper/db/user.dart';
import 'package:learning_helper/secrets/secrets.dart';

class SocialLogin extends StatefulWidget {
  const SocialLogin({super.key});

  @override
  State<StatefulWidget> createState() => _SocialLoginState();
}

String googleSVG = '''
<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" xmlns:xlink="http://www.w3.org/1999/xlink" style="display: block;">
        <path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"></path>
        <path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"></path>
        <path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"></path>
        <path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"></path>
        <path fill="none" d="M0 0h48v48H0z"></path>
      </svg>
''';

String githubSVG = '''
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-github" viewBox="0 0 16 16">
  <path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27s1.36.09 2 .27c1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.01 8.01 0 0 0 16 8c0-4.42-3.58-8-8-8"/>
</svg>
''';

class _SocialLoginState extends State<SocialLogin> {
  String? _errorMessege;

  final String _redirectUri = 'https://learning-helper.web.app/__/auth/handler';
  late final GoogleSignInArgs _googleArgs;
  late final GitHubSignInArgs _githubArgs;

  @override
  void initState() {
    super.initState();

    _googleArgs = GoogleSignInArgs(
      clientId: webClientId,
      redirectUri: _redirectUri,
      scope: 'email profile',
    );

    _githubArgs = GitHubSignInArgs(
      clientId: githubClientId,
      clientSecret: githubClientSecret,
      redirectUri: _redirectUri,
      scope: 'read:user user:email',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            'Login or Signup through Social Platform: ',
            style: TextTheme.of(context).labelLarge,
          ),
          if (_errorMessege != null) ...[
            Text(
              _errorMessege!,
              style: TextTheme.of(
                context,
              ).bodySmall!.copyWith(color: Colors.red),
            ),
            SizedBox(height: 5),
          ] else
            SizedBox(height: 10),
          Column(
            spacing: 20,
            children: [
              Container(
                constraints: BoxConstraints(maxHeight: 50, maxWidth: 780),
                child: OutlinedButton(
                  onPressed: _signinWithGoogle,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xFF131314),
                    foregroundColor: Color(0xFFE3E3E3),
                    side: BorderSide(color: Color(0xFF8E918F), width: 1),
                    shape: StadiumBorder(),
                    padding: EdgeInsets.only(left: 12, right: 20),
                  ),
                  child: Row(
                    spacing: 12,
                    mainAxisAlignment: .start,
                    crossAxisAlignment: .center,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.symmetric(vertical: 4),
                        child: SvgPicture.string(googleSVG),
                      ),
                      Spacer(),
                      Text(
                        'Continue with Google',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.25,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(maxHeight: 50, maxWidth: 780),
                child: OutlinedButton(
                  onPressed: _signinWithGithub,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xFF131314),
                    foregroundColor: Color(0xFFE3E3E3),
                    side: BorderSide(color: Color(0xFF8E918F), width: 1),
                    shape: StadiumBorder(),
                    padding: EdgeInsets.only(left: 12, right: 20),
                  ),
                  child: Row(
                    spacing: 12,
                    mainAxisAlignment: .start,
                    crossAxisAlignment: .center,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.symmetric(vertical: 4),
                        child: SvgPicture.string(githubSVG),
                      ),
                      Spacer(),
                      Text(
                        'Continue with github',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.25,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _signinWithGoogle() async {
    setState(() {
      _errorMessege = null;
    });

    try {
      final AuthResult? result = await DesktopWebviewAuth.signIn(_googleArgs);

      if (result == null || result.accessToken == null) {
        setState(() {
          _errorMessege = 'Google sign in failed';
        });

        if (kDebugMode) print('Google sign in failed');
        return;
      }

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: result.accessToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      await _handleUserSession(userCredential);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessege = 'Firebase Auth Exception: ${e.message}';
      });

      if (kDebugMode) {
        print(e.code);
      }
    } on FirebaseException catch (e) {
      setState(() {
        _errorMessege = 'Firebase Exception: ${e.message}';
      });

      if (kDebugMode) {
        print(e.code);
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  void _signinWithGithub() async {
    setState(() => _errorMessege = null);

    try {
      final AuthResult? result = await DesktopWebviewAuth.signIn(_githubArgs);

      if (result == null ||
          result.accessToken == null ||
          result.accessToken == null) {
        setState(() {
          _errorMessege = 'Github sign in failed';
        });

        if (kDebugMode) print('Gtihbu Sign in failed');
        return;
      }

      final AuthCredential credential = GithubAuthProvider.credential(
        result.accessToken!,
      );
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      await _handleUserSession(userCredential);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessege = 'GitHub Auth Exception: ${e.message}';
      });
      if (kDebugMode) print(e.code);
    } on FirebaseException catch (e) {
      setState(() {
        _errorMessege = 'Firebase Exception: ${e.message}';
      });
      if (kDebugMode) print(e.code);
    } catch (e) {
      setState(() {
        _errorMessege = 'GitHub Signin Failed: $e';
      });
      if (kDebugMode) print(e);
    }
  }

  Future<void> _createDatabaseUser({
    required String userId,
    required String name,
    required String email,
    String? photoURL,
  }) async {
    final DatabaseReference userRefrence = FirebaseDatabase.instance.ref(
      'users/$userId',
    );

    await userRefrence.set({
      'name': name,
      'email': email,
      'photoURL': ?photoURL,
    });
  }

  Future<void> _handleUserSession(UserCredential userCredential) async {
    final firebaseUser = userCredential.user;
    if (firebaseUser == null) return;

    final String uid = firebaseUser.uid;
    final String name = firebaseUser.displayName ?? '';
    final String email = firebaseUser.email ?? '';

    final DatabaseReference ref = FirebaseDatabase.instance.ref('users/$uid');

    final snapshot = await ref.get();
    if (!snapshot.exists) {
      await _createDatabaseUser(
        userId: uid,
        name: name,
        email: email,
        photoURL: firebaseUser.photoURL,
      );
    }

    setState(() {
      currentUser = User(uid: uid, name: name, email: email);
    });
  }
}
