// ignore_for_file: file_names

import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi{
static final googleSignIn=GoogleSignIn();
static Future<GoogleSignInAccount?> login() =>googleSignIn.signIn();
static Future<void> logout() => googleSignIn.signOut();


}