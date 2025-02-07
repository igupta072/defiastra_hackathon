import 'package:defiastra_hackathon/module/signin/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  static String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log in'),),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            controller.signInWithGoogle();
            // if (authResponse != null) {
            //   // Navigate to home screen or show success message
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text('Successfully signed in!')),
            //   );
            // } else {
            //   // Show error message
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text('Sign in failed')),
            //   );
            // }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/ic_google.png', // Make sure to add this asset
                  height: 24.0,
                ),
                SizedBox(width: 12.r),
                const Text('Sign in with Google'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}