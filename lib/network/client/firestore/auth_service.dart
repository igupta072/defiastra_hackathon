import 'package:defiastra_hackathon/network/client/firestore/base_service.dart';
import 'package:defiastra_hackathon/util/callback_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:okto_network_manager/network/http/api.dart';
import 'package:okto_network_manager/service_config.dart';
import 'package:okto_sdk/network/model/auth_response_v2.dart';
import 'package:okto_sdk/okto_flutter_sdk.dart';

class FireStoreAuthService extends IFirebaseService<FirebaseAuth> {

  FireStoreAuthService({required super.config});

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
      'openid',
    ],
    serverClientId: '81368794175-6ugggrda88kmg1lmjtdpigrs0mc3j2ao.apps.googleusercontent.com',
    forceCodeForRefreshToken: true,
  );

  Future<AuthResponseV2?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      return OktoSdk().loginWithIdTokenV2(idToken: googleAuth!.idToken!, authProvider: 'google');
    } catch (e) {
      debugPrint('Error signing in with Google: $e');
      return null;
    }
  }

  void sendOTP(
      {required String mobileNo,
      required void Function(PhoneAuthCredential) verificationCompleted,
      required void Function(FirebaseAuthException) verificationFailed,
      required void Function(String, int?) codeSent,
      required void Function(String) codeAutoRetrievalTimeout,
      Duration timeout = const Duration(seconds: 30)}) {
    serviceInstance.verifyPhoneNumber(
        phoneNumber: mobileNo,
        timeout: timeout,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void deleteUser(
      {required ResultCallback<ApiStatus> onComplete,
      UserCredential? userCredential}) {
    User? user = userCredential?.user ?? serviceInstance.currentUser;
    user?.delete().then((value) {
      onComplete(ApiStatus.success);
    });
  }

  User? get user => serviceInstance.currentUser;

  Future<void> logout() => serviceInstance.signOut();

  void verifyOtp(
      {required String verificationId,
      required String otp,
      required ResultCallback<UserCredential> onSuccess,
      required VoidCallback onError}) {
    final authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    serviceInstance.signInWithCredential(authCredential).then((value) {
      onSuccess(value);
    }).catchError((onError) {
      onError();
    });
  }
}
